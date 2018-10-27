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

  def myfriend
      set_user
      @friends = @user.friends + @user.inverse_friends
      @appliers = @user.inverse_applyfriendmans
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

  def apply
      set_user      
      @apply = Applyfriend.new( user_id: current_user.id, friend_id: @user.id ) 
      if @apply.save
      flash[:notice] = '已送出好友申請！'
      else
        flash[:alert] = @apply.errors.full_messages.to_sentence
      end  
  end

  def check
      set_user
      applyfriend = @user.applyfriends.where("friend_id = #{current_user.id}").first
      applyfriend.destroy
      @friendship = Friendship.new( user_id: current_user.id, friend_id: @user.id ) 
      if @friendship.save
      flash[:notice] = '已確認好友申請！'
      else
        flash[:alert] = @friend.errors.full_messages.to_sentence
      end  
      redirect_to myfriend_user_path(current_user)
  end

  def unfriend
      @friendship = Friendship.find(params[:id])
      if @friendship.destroy
      flash[:notice] = '已取消好友！'
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
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
