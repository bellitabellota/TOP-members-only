class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new()
  end

  def create
    @user = User.find(current_user.id)
    @post = @user.posts.create(permitted_post_params)

    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def permitted_post_params
    params.require(:post).permit(:title, :body)
  end
end
