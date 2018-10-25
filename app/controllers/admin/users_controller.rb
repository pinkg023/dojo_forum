class Admin::UsersController < ApplicationController
 before_action :authenticate_admin

  def index
    @users = User.all
    @user = User.new
  end

  def enadmin
    set_user
    @user.role = "admin"
    if @user.save
      flash[:notice] = "user was set to be Admin"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      @users = User.all
    end
    redirect_to admin_root_path
  end

  def unadmin
    set_user
    @user.role = ""
    if @user.save
      flash[:notice] = "user was set to be Normal"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      @users = User.all
    end
    redirect_to admin_root_path
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def set_user
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = User.new
    end
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
