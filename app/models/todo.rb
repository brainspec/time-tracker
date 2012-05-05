class Todo
  include Mongoid::Document

  field :project_id,    type: Integer
  field :bcx_id,        type: Integer
  field :created_at,    type: Time
  field :title,         type: String
  field :first_comment, type: String

  belongs_to :project

  has_many :time_entries

  class << self
    def find_or_create_by_bcx_hash(bcx_hash)
      find_or_initialize_by(bcx_id: bcx_hash.id).tap do |todo|
        todo.created_at    = bcx_hash.created_at
        todo.title         = bcx_hash.content
        todo.first_comment = bcx_hash.comments.first.content
        todo.save!
      end
    end
  end

  def total_hours
    time_entries.sum(:hours) || 0
  end
end
