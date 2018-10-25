class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path

    else
      @categories = Category.all
      render :index
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category was successfully updated"
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    #@category = Category.find(params[:id])
    @category_default=Category.find(0)
    @category_default.restaurants << @category.restaurants    #當所屬分類被刪除時，修改餐廳分類為預設值
    @category.destroy
    flash[:alert] = "category was successfully deleted"
    redirect_to admin_categories_path
  end


  private

  def set_category
    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
