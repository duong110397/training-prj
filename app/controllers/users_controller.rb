class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    if @user.errors.full_messages.any?
      errors_message =@user.errors.full_messages.join(", ")
      redirect_to new_user_url, :alert => errors_message
    else
      redirect_to users_url, :notice => "create user success"
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
end
