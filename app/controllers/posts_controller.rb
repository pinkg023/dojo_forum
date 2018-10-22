class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @category = nil
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
    if @category.nil?
      @posts = Post.order(last_reply_time: :desc).page(params[:page]).per(20)
    else
      @posts = Post.posts.order(last_reply_time: :desc).page(params[:page]).per(20)
    end
      
    @user = current_user
  end

  def order_most_reply
    @categories = Category.all
    @posts = Post.order(replies_count: :desc).page(params[:page]).per(20)
    @user = current_user
  end

  def new
    @categories = Category.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = '發布貼文！'
      redirect_to posts_path
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
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
      params.require(:post).permit( :title, :description, :category_ids, :image)
    end

    def reply_params
      params.require(:reply).permit(:comment, :user_id, :post_id, :created_at, :updated_at)
    end

end
