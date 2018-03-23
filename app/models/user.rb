class User < ActiveRecord::Base
  validates :name, :email, :provider_name, :provider_id, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i } 

  def self.find_or_create_from_auth_hash(auth_hash)
    User.new(:name => auth_hash.info.name, :email => auth_hash.info.email, :provider_name => auth_hash.provider, :provider_id => auth_hash.uid)
  end
end
