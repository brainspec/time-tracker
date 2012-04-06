class TimeEntry
  include Mongoid::Document

  field :user_id, :type => Integer
  field :todo_id, :type => Integer
  field :hours, :type => Float
  field :comment, :type => String

  belongs_to :user

  validates :hours, presence: true, numericality: true

  def hours=(h)
    write_attribute :hours, (h.is_a?(String) ? (h.to_hours || h) : h)
  end
end
