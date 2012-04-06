class TimeEntry
  include Mongoid::Document

  field :user_id, :type => Integer
  field :todo_id, :type => Integer
  field :hours, :type => Float
  field :comment, :type => String

  belongs_to :user
end
