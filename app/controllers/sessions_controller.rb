class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  # prepend_before_action :already_logged_in?, only:[:new, :create]
  
  def new
  end
    
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    redirect_to user_path(user.id)
    else
    flash[:danger] = 'ログインに失敗しました'
    render :new
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private
  
  def already_logged_in?
    if logged_in?
      redirect_to tasks_path, notice: 'ログアウトしました'
    end
  end
end
