class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def show
      @categories = Category.all
      @category = Category.find(params[:id])
      @posts = @category.posts.page(params[:page]).per(20)
  end

end
