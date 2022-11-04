class PostsController < ApplicationController
  before_action :logged_in, except: [:index, :show_post_guest, :show, :create_post_guest]
  before_action :find_post, only: [:show, :edit, :update, :approve_post_guest]
  before_action :admin_role, only: [:destroy, :approve_post_guest, :show_all_post_guest]
  before_action :correct_user, only: [:edit, :update]
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
  
  def show_all_post_guest
    @posts = Post.where(commit_status: 0)
  end

  def show_post_guest
  end

  def approve_post_guest
    commit_status = params[:commit_status]
    if commit_status == 'approve'
      @post.update(commit_status: 2, status: 1)
      redirect_to root_url, :notice => "Has Approve post public" 
    elsif commit_status == 'reject'
      @post.update(commit_status: 1, status: 0)
      redirect_to root_url, :alert => "Has Reject post" 
    end
  end
  
  def create_post_guest  
    @post = Post.new(title: params[:title], content: params[:content], commit_status: 0, status: 0)
    @post.image.attach(params[:image])
    if @post.save
      redirect_to root_url, :notice => "You have successfully posted, your post is waiting for approval"
    else
      redirect_to root_url, :alert => "Has errors in during create posted"
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
		redirect_to root_url, :alert => "Post not exist" if @post.nil?
	end

  def post_params
    params.require(:post).permit(:content, :title, :status, :image)
  end

  def correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user
      redirect_to root_url, :alert => "You are not allowed" unless current_user.admin? || @post.user == current_user
    else
      redirect_to root_url, :alert => "You are not allowed" unless current_user.admin?
    end
  end
end