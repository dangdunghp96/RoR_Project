class SessionsController < ApplicationController
  skip_before_action :require_signin, only: :create

  def create
    if params[:session].present?
      user = User.find_by email: params[:session][:email].downcase
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        get_cart user
        if user.address && user.phone_number && user.name
          flash[:success] = "Welcome!"
          redirect_to root_path
        else
          flash[:success] = "Please update your profile!"
          redirect_to user
        end
      else
        flash[:danger] = "The account name or password that you have entered is incorrect."
        redirect_to root_path
      end
    else
      begin
        user = User.from_omniauth request.env["omniauth.auth"]
        session[:user_id] = user.id
        flash[:success] = "Welcome!"
      rescue
        flash[:warning]  = "Error"
      end
      redirect_to root_path
    end
  end

  def destroy
    log_out if log_in?
    redirect_to root_url
  end
end


