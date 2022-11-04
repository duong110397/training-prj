class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def logged_in
    redirect_to user_session_path, alert: "Please login to continue" unless user_signed_in?
  end

  def admin_role
    redirect_to root_url, :alert => "You are not allowed" unless current_user.admin?
  end

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end
end
