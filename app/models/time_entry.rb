class TimeEntry
  include Mongoid::Document

  field :user_id, :type => Integer
  field :todo_id, :type => Integer
  field :hours, :type => Float
  field :comment, :type => String

  belongs_to :user

  validates :hours, presence: true, numericality: {greater_than: 0}

  def hours=(h)
    write_attribute :hours, (h.is_a?(String) ? (h.to_hours || h) : h)
  end

  def self.todo_total_time(todo_id)
    total = where(todo_id: todo_id ).sum(:hours)
    total.round(2) if total
  end
end
