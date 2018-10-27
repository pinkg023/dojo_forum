class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def show
      @categories = Category.all
      @category = Category.find(params[:id])
      @posts = @category.posts.page(params[:page]).per(20)
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

end
