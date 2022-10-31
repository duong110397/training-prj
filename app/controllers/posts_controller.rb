class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update]
  def index
    @posts = Post.where(status: 1).order(created_at: :desc)
  end
    
  def new
    @post =Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image])
    if @post.save
      redirect_to root_url, :notice => "Post has create"
    else
      render :new
    end
  end
    
  def show
  end

  def edit
  end

  def update
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to root_url, :alert => "delete post success"
  end

  def postme
    @posts = Post.where(user_id: current_user.id)
  end
	private
	
	def find_post
		@post = Post.find_by(id: params[:id])
		if @post.nil?
			redirect_to root_url, :alert => "Post not exist"
		end
	end

  def post_params
    params.require(:post).permit(:content, :title, :status, :image)
  end
end
