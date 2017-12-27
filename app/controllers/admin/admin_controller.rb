class Admin::AdminController < ActionController::Base
  layout 'admin'
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :require_signin, :auth_admin

  def index
  end

  def require_signin
    unless log_in?
      flash[:danger] = "You need to sign in!"
      redirect_to root_path
    end
  end

  def auth_admin
    unless current_user.admin?
      flash[:danger] = "Permission denied!"
      redirect_to root_path
    end
  end
end
