class Reply < ApplicationRecord
  belongs_to :post, :counter_cache => true
  belongs_to :user, :counter_cache => true

  after_save :update_post_cache_data

  protected

  def update_post_cache_data
    self.post.update_reply_cache
  end

end