class Todo
  include Mongoid::Document

  field :bcx_id, type: Integer
  field :created_at, type: Time

  has_many :time_entries

  class << self
    def find_or_create_by_bcx_hash(bcx_hash)
      Todo.find_or_initialize_by(bcx_id: bcx_hash.id).tap do |todo|
        todo.created_at = bcx_hash.created_at
        todo.save!
      end
    end
  end
end
