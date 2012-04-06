class User
  include Mongoid::Document

  field :uid,  type: String
  field :name, type: String

  class << self
    def find_or_create_by_auth_hash(auth_hash)
      User.find_or_initialize_by(uid: auth_hash.uid).tap do |user|
        user.name = auth_hash.info.name
        user.save!
      end
    end
  end
end
