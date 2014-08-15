# User model
class User < ActiveRecord::Base
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { case_sensitive: false, scope: :provider }
  validates :username, presence: true, length: { in: 1..255 }
  validates :name, presence: true, length: { in: 2..20 }
  validates :avatar_url, presence: true, length: { maximum: 255 }
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
