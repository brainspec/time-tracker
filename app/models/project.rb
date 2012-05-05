class Project
  include Mongoid::Document

  field :bcx_id, type: Integer

  has_many :todos

  class << self
    def find_or_create_by_bcx_hash(bcx_hash)
      find_or_initialize_by(bcx_id: bcx_hash.id).tap do |todo|
        todo.save!
      end
    end
  end
end
