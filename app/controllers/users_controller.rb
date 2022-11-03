class UsersController < ApplicationController
  before_action :logged_in
  before_action :find_user, only: [:edit, :update, :show]
  before_action :admin_role, only: [:new, :destroy, :create]
  before_action :correct_user, only: [:edit, :update]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_url, :notice => "create user success"
    else
      render :new
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_url, :notice => "update user success"
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, :alert => "delete user success"
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :birthday)
  end
  
  def find_user
    if User.exists?(params[:id])
      @user = User.find(params[:id])   
    else 
      redirect_to users_url, alert: "user not exists"
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url, :alert => "User not exists" if @user.nil?
    redirect_to root_url, :alert => "You are not allowed" unless current_user.admin? || @user == current_user
  end
end
