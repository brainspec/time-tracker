class TimeEntry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Integer
  field :todo_id, type: Integer
  field :hours,   type: Float
  field :comment, type: String

  field :title, type: String

  belongs_to :user

  validates :hours, presence: true, numericality: {greater_than: 0}

  scope :this_day, lambda {
    where(:created_at.gte => Time.now.beginning_of_day,
          :created_at.lte => Time.now)
  }

  def hours=(h)
    write_attribute :hours, (h.is_a?(String) ? (h.to_hours || h) : h)
  end

  def self.todo_total_time(todo_id)
    total = where(todo_id: todo_id ).sum(:hours)
    total.round(2) if total
  end
end
