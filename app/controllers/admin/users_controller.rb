class Admin::UsersController < ApplicationController
  before_action :admin_check, only: [:destroy, :edit]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :login_required, only:[:new, :create]


  def index
    @users = User.select(:id, :name, :email, :admin).order("created_at").page(params[:page]).per(5)
  end


  def show
  end


  def new
    @user = User.new
  end


  def edit
  end


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"ユーザーを登録しました"
    else
      render :new
    end
  end


  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを更新しました"
    else
      render :edit
    end
  end


  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "削除しました"
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_check
    unless current_user && current_user.admin?
      redirect_to tasks_path, notice: "管理者以外はアクセス不可です"
    end
  end
end
