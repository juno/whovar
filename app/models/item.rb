# Item model
class Item < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
end

# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null, indexed
#  title      :string(255)      not null
#  url        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_items_on_user_id  (user_id)
#
