class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def show
      @categories = Category.all
      @category = Category.find(params[:id])
      @posts = @category.posts.page(params[:page]).per(20)
      #@posts = Post.where(draft: false, category_id: params[:id]).page(params[:page]).per(20)

  end

  def order_last_reply
    @categories = Category.all
    @category = Category.find(params[:id])
    @posts = @category.posts.order(last_reply_time: :desc).page(params[:page]).per(20)      
    @user = current_user
  end

  def order_most_reply
    @categories = Category.all
    @category = Category.find(params[:id])
    @posts = @category.posts.order(replies_count: :desc).page(params[:page]).per(20)
    @user = current_user
  end

  def order_most_view
    @categories = Category.all
    @category = Category.find(params[:id])
    @posts = @category.posts.order(views_count: :desc).page(params[:page]).per(20)
    @user = current_user
  end

end