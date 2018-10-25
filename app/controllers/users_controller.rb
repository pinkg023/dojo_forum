class UsersController < ApplicationController
  before_action :authenticate_user!

  def mypost
      set_user
      @posts = @user.posts.page(params[:page]).per(20)
  end

  def mycomment
      set_user
      @user_replies = @user.replies
      @posts = []
      @user_replies.each do |reply|
        tposts = reply.post
        @posts = @posts << tposts 
      end
      @posts = @posts.uniq
      #authorize! :read, @post
      return(@posts)
  end

  def mycollect
      set_user
      @posts = @user.collect_posts.page(params[:page]).per(20)
  end

  def mydraft
      set_user
      @posts = @user.posts.page(params[:page]).per(20)
  end

  def edit
    set_user
  end

  def update
    set_user
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "user was successfully updated"
        redirect_to mypost_user_path(@user)      
      else
        render edit_user_path(@user)
        flash[:alert] = @user.errors.full_messages.to_sentence
      end
    else 
      flash[:alert] = "You can not edit other's profile."
      redirect_to edit_user_path(@user)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
