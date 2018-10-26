class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
    render json: {
      data: @posts
    }
  end

  def show
    @post = Post.find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    else
      render json: {
        data: @post
      }
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      render json: {
        message: "Post created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.user.authentication_token != params[:auth_token]
      render json: {
        message: "You have no permittion!",
      }
    else
      if @post.update(post_params)
        render json: {
          message: "Post updated successfully!",
          result: @post
        }
      else
        render json: {
          errors: @post.errors
        }
      end
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.user.authentication_token != params[:auth_token]
      render json: {
        message: "You have no permittion!",
      }
    else    
      @post.destroy
      render json: {
        message: "Post destroy successfully!"
      }
    end
  end

  private

  def post_params
    params.permit(:title, :description, :user_id, :image, :draft, :replies_count, :view_count)
  end

end
