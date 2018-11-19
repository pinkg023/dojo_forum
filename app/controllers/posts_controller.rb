class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  impressionist :actions=>[:show]

  def index
    @categories = Category.all
    @posts = Post.where(draft: false).page(params[:page]).per(20)
    @user = current_user
    @recent_posts = Post.order(created_at: :desc).limit(10)
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

  def order_most_view
    @categories = Category.all
    @posts = Post.order(views_count: :desc).page(params[:page]).per(20)
    @user = current_user
  end

  def new
    @categories = Category.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @category = params[:post][:category_ids]
    @post.category_ids = @category
    if @post.save
      flash[:notice] = '發布貼文！'
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
    redirect_to mypost_user_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    if (current_user.admin? || @post.user == current_user)
      @post.destroy
    end
    if @post.present?
      flash[:alert] = @post.errors.full_messages.to_sentence
    else
      flash[:alert] = "Post was successfully deleted" 
    end
    if current_user.admin?
      redirect_to root_path
    else
      redirect_to mypost_user_path(@post.user)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @category = params[:post][:category_ids]
    @post.category_ids = @category
    if @post.user == current_user
      if @post.update(post_params)
        flash[:notice] = "post was be successfully updated"             
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
      end
      redirect_to mypost_user_path(@post.user) 
    else 
      flash[:alert] = "You can not edit other's post."
      redirect_to edit_post_path(@user)
    end
  end

  def show
      @post = Post.find(params[:id])
      impressionist(@post)
      @post.views_count = @post.impressionist_count
      @post.save
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

  def collect
    @post = Post.find(params[:id])
    @collect = Collect.new( user_id: current_user.id, post_id: @post.id ) 
    if @collect.save
      flash[:notice] = '成功收藏！'
    else
      flash[:alert] = @collet.errors.full_messages.to_sentence
    end  
    #redirect_to post_path(@post)
  end

  def uncollect
    @post = Post.find(params[:id])
    @collect = current_user.collects.where(post_id: params[:id]).first
    if @collect.destroy
      flash[:notice] = '已取消收藏'
    else
      flash[:alert] = @collet.errors.full_messages.to_sentence
    end  
    #redirect_to post_path(@post)
  end

  private

    def post_params
      params.require(:post).permit( :title, :description, :category_ids, :image, :draft, :access_right)
    end

    def reply_params
      params.require(:reply).permit(:comment, :user_id, :post_id, :created_at, :updated_at)
    end

end
