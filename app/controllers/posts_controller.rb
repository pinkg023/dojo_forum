class PostsController < ApplicationController
  before_action :authenticate_user!, only: []
  def index
    @posts = Post.page(params[:page]).per(10)
    @user = current_user
    @recent_posts = Post.order(created_at: :desc).limit(10)
    @pop_posts = Post.order(likes_count: :desc).limit(10)
    @post = Post.new
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def show
      @post = Post.find(params[:id])
      # @post.replies.each do |reply|
      #   reply.upvotes_count = reply.reply_upvotes.count
      #   reply.save!
      # end
      @replies = @post.replies.page(params[:page]).per(20)
      @reply = Reply.new
  end

  private

    def post_params
      params.require(:post).permit( :title, :description)
    end

end
