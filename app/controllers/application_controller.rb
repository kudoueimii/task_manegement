class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  # before_action :not_login_user
  
  private
  def login_required
    redirect_to new_session_path unless current_user
  end

  def not_login_user
    if logged_in?
      flash[:notice] = "ログインしています"
      redirect_to tasks_path
    end
  end

end
