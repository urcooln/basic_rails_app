class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def create
      @user = User.find_by(id: params[:user_id])
      
      if @user.nil?
        render json: { error: 'User not found' }, status: :not_found
        return
      end
  
      @post = @user.posts.new(post_params)
  
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def index
      @posts = Post.all
      render json: @posts
    end
  
    private
  
    def post_params
      params.require(:post).permit(:content)
    end
  end
  