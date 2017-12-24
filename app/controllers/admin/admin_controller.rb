class Admin::AdminController < ActionController::Base
  layout 'admin'
  protect_from_forgery with: :exception
  def index

  end
end
