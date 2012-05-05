class TimeEntry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id,     type: Integer
  field :todo_id,     type: Integer
  field :project_id,  type: Integer
  field :bcx_todo_id, type: Integer

  field :hours,   type: Float
  field :comment, type: String

  field :title, type: String

  MAX_TODAY_TOTAL_TIME = 16

  belongs_to :user
  belongs_to :todo
  belongs_to :project

  validates :hours, presence: true, numericality: {greater_than: 0}

  validate :overdue_today_total_time

  scope :this_day, lambda {
    where(:created_at.gte => Time.now.beginning_of_day,
          :created_at.lte => Time.now)
  }

  def hours=(h)
    write_attribute :hours, (h.is_a?(String) ? (h.to_hours || h) : h)
  end

  def self.todo_total_time(todo_id)
    total = where(todo_id: todo_id).sum(:hours)
    total.round(2) if total
  end

  def self.created_between(date_from, date_to)
    created_at_gte = (Time.zone.parse(date_from || '') || Time.zone.now.beginning_of_month).beginning_of_day
    created_at_lte = (Time.zone.parse(date_to || '') || Time.zone.now).end_of_day

    self.where(:created_at.gte => created_at_gte, :created_at.lte => created_at_lte)
  end

  private

  def overdue_today_total_time
    today_total_time = user.today_total_time + hours

    if today_total_time > MAX_TODAY_TOTAL_TIME
      errors.add(:hours, I18n.t(:overdue_total_time, :overdue => (today_total_time - MAX_TODAY_TOTAL_TIME)))
    end
  end
end
