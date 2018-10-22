class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @categories = Category.all
    @posts = Post.page(params[:page]).per(20)
    @user = current_user
    @recent_posts = Post.order(created_at: :desc).limit(10)
    @pop_posts = Post.order(likes_count: :desc).limit(10)
    @post = Post.new
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def order_last_reply
    @categories = Category.all
    @posts = Post.order(last_reply_time: :desc).page(params[:page]).per(20)
    @user = current_user
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

  def reply
    @post = Post.find(params[:id])
    reply_params
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      flash[:notice] = '回覆完成'
    else
      flash[:alert] = @reply.errors.full_messages.to_sentence
    end
    redirect_to post_path(@post)
  end

  private

    def post_params
      params.require(:post).permit( :title, :description)
    end

    def reply_params
      params.require(:reply).permit(:comment, :user_id, :post_id, :created_at, :updated_at)
    end

end
