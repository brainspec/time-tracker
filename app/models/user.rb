class User
  include Mongoid::Document

  field :uid,  type: String
  field :name, type: String

  field :token, type: String

  has_many :time_entries

  class << self
    def find_or_create_by_auth_hash(auth_hash)
      User.find_or_initialize_by(uid: auth_hash.uid).tap do |user|
        user.name  = auth_hash.info.name
        user.token = auth_hash.credentials.token
        user.save!
      end
    end
  end

  def today_total_time
    total = time_entries.where(:created_at.gte => Time.now.beginning_of_day,
                               :created_at.lte => Time.now).sum(:hours)
    total.round(2) if total
  end
end
