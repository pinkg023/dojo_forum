class Admin::PostsController < ApplicationController
  before_action :authenticate_admin

  def index
    @categories = Category.all
    @posts = Post.page(params[:page]).per(20)
    @user = current_user
    @recent_posts = Post.order(created_at: :desc).limit(10)
    @post = Post.new
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

end
