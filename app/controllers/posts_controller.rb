class PostsController < ApplicationController
  before_action :logged_in, except: [:index, :show, :new_post_guest, :create_post_guest]
  before_action :find_post, only: [:show, :edit, :update, :confirm_post_guest, :destroy, :upvote, :downvote]
  before_action :admin_role, only: [:destroy, :confirm_post_guest, :all_posts_guest]
  before_action :correct_user, only: [:edit, :update]
  def index
    @posts = Post.where(status: "public_post").order(created_at: :desc)
  end
    
  def upvote
    if current_user.voted_up_on? @post
      @post.unvote_by current_user
    else
      @post.upvote_by current_user
    end
    respond_to do |format|
      format.js { render :action => 'vote' }
    end
  end

  def downvote
    if current_user.voted_down_on? @post
      @post.unvote_by current_user
    else
      @post.downvote_by current_user
    end
    respond_to do |format|
      format.js { render :action => 'vote' }
    end
  end
  def new
    @post = Post.new
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
  
  def all_posts_guest
    @posts = Post.where(commit_status: "waiting_status")
  end

  def new_post_guest
  end

  def confirm_post_guest
    commit_status = params[:commit_status]
    if commit_status == 'approve'
      @post.update(commit_status: "approve_status", status: "public_post")
      redirect_to root_url, :notice => "Has Approve post public" 
    elsif commit_status == 'reject'
      @post.update(commit_status: "reject_status", status: "non_public")
      redirect_to root_url, :alert => "Has Reject post" 
    end
  end
  
  def create_post_guest  
    @post = Post.new(title: params[:title], content: params[:content], commit_status: "waiting_status", status: "non_public")
    @post.image.attach(params[:image])
    if @post.save
      # client = Slack::Web::Client.new
      # client.auth_test
      # client.chat_postMessage(channel: '#general', text: markdown_text(@post))
      redirect_to root_url, :notice => "You have successfully posted, your post is waiting for approval"
    else
      redirect_to root_url, :alert => "Has errors in during create posted"
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
  end

  def update
  end

  def destroy
    @post.destroy
  end

  def my_posts
    @posts = Post.where(user_id: current_user.id)
  end

  private

  def markdown_text(post)
    <<~TEXT
    :white_check_mark: Post guest waiting status
    *title*: #{post.title}
    *content*: #{post.content}
    TEXT
  end
  
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
