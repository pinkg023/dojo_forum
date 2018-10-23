class Admin::CategoriesController < ApplicationController
 before_action :authenticate_admin

  def index
    @categories = Category.all
    @category = Category.new
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

  def show
    @category = Category.find(params[:id])
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
    @category = Category.find(params[:id])
    @category.destroy
    if @category.present?
      flash[:alert] = @category.errors.full_messages.to_sentence
    else
      flash[:alert] = "Category was successfully deleted" 
    end
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
