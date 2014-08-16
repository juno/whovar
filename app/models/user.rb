# User model
class User < ActiveRecord::Base
  has_many :items, dependent: :restrict_with_exception

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { case_sensitive: false, scope: :provider }
  validates :username, presence: true, length: { in: 1..255 }
  validates :name, presence: true, length: { in: 2..20 }
  validates :avatar_url, presence: true, length: { maximum: 255 }

  # Public: Returns an instance of User which corresponds to
  # specified auth hash.
  #
  # If an user does not exist, it will create.
  # Attributes of the User will update with auth values.
  #
  # auth - An instance of OmniAuth::AuthHash.
  #
  # Returns User.
  def self.from_omniauth(auth)
    user = where(auth.slice('provider', 'uid')).first
    user ? update_user!(user, auth) : create_from_omniauth!(auth)
  end

  private

  # Internal: Creates a new user with specified auth.
  #
  # auth - An instance of OmniAuth::AuthHash.
  #
  # Returns User.
  def self.create_from_omniauth!(auth)
    attrs = {
      provider: auth['provider'],
      uid: auth['uid'],
      username: auth['info']['nickname'],
      name: auth['info']['name'],
      avatar_url: auth['info']['image'],
    }
    create!(attrs)
  end

  # Internal: Update specified user with auth.
  #
  # user - An instance of User to update.
  # auth - An instance of OmniAuth::AuthHash.
  #
  # Returns User.
  def self.update_user!(user, auth)
    attrs = {
      username: auth['info']['nickname'],
      name: auth['info']['name'],
      avatar_url: auth['info']['image'],
    }
    user.update!(attrs)
    user
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string(255)      not null, indexed => [uid]
#  uid        :string(255)      not null, indexed => [provider]
#  username   :string(255)      not null
#  name       :string(255)      not null
#  avatar_url :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#
