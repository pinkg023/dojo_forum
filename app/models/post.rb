class Post < ApplicationRecord
  has_many :replies
  belongs_to :user
  has_many :caterelates
  has_many :post_cates, through: :caterelates, source: :category

  def update_reply_cache
    self.last_reply_time = self.replies.last.try(:created_at)
    self.save(:validate => false)
  end

end