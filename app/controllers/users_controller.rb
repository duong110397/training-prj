class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.errors.any?
      errors_messages = @user.errors.messages
      redirect_to new_user_url, :alert => errors_messages
    end
    if @user.save
      redirect_to users_url, :notice => "create user success"
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_url, :notice => "update user success"
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
end
