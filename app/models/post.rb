class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  is_impressionable

  has_many :replies, :dependent => :destroy
  belongs_to :user
  has_many :caterelates
  has_many :categories, through: :caterelates
  has_many :collects
  has_many :collect_users, through: :collects, source: :user

  def update_reply_cache
    self.last_reply_time = self.replies.last.try(:created_at)
    self.save(:validate => false)
  end

  def self.publish_myself(user)
    where(user_id: user.id)
  end

  def self.publish_myfriends(friends_id)
    where(user_id: friends_id, draft: false, access_right: 1)
  end

  def self.publish_all
    where(draft: false, access_right: 0)
  end

end