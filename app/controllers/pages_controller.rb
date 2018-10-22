class PagesController < ApplicationController
before_action :authenticate_user!
  def feed
      @popular_posts = Post.order(replies_count: :desc).limit(10)
      @chatterboxs = User.order(replies_count: :desc).limit(10)
  end
end
