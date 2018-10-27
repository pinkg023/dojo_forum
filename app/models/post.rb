class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  is_impressionable

  has_many :replies, :dependent => :destroy
  belongs_to :user
  has_many :caterelates
  has_many :categories, through: :caterelates, source: :category
  has_many :collects
  has_many :collect_users, through: :collects, source: :user

  def update_reply_cache
    self.last_reply_time = self.replies.last.try(:created_at)
    self.save(:validate => false)
  end

end