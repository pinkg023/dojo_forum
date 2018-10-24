class UsersController < ApplicationController
  before_action :authenticate_user!

  def mypost
      @user = User.find(params[:id])
      @posts = @user.posts.page(params[:page]).per(20)
  end

  def mycomment
      @user = User.find(params[:id])
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
end
