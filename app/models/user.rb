class User
  include Mongoid::Document

  include Draper::ModelSupport

  field :uid,  type: String
  field :name, type: String

  field :token, type: String
  field :refresh_token, type: String

  has_many :time_entries

  class << self
    def find_or_create_by_auth_hash(auth_hash)
      User.find_or_initialize_by(uid: auth_hash.uid).tap do |user|
        user.name  = auth_hash.info.name
        user.token = auth_hash.credentials.token
        user.refresh_token = auth_hash.credentials.refresh_token
        user.save!
      end
    end
  end

  def today_total_time
    total = time_entries.this_day.sum(:hours)
    total ||= 0
    total.round(2)
  end
end
