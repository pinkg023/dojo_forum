class PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(10)
    @user = current_user
    @recent_posts = Post.order(created_at: :desc).limit(10)
    @pop_posts = Post.order(likes_count: :desc).limit(10)
    @post = Post.new
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end
end
