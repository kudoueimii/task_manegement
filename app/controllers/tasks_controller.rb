class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :check_user, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks.all.includes(:user)
    if params[:sort_deadline]
      @tasks = current_user.tasks.deadline
    end
    if params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :asc)
    end
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if params[:task].present? && params[:task][:status].present?
        @tasks = current_user.tasks.search_title(title).search_status(status)
      elsif params[:task].present?
        @tasks = current_user.tasks.search_title(title)
      elsif params[:status].present?
        @tasks = current_user.tasks.search_status(status)
      end
    end
    @tasks = @tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "作成されました。"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集されました。"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:title, :detail, :deadline_at, :status, :priority, :page, :admin)
  end

  def check_user
    @task = Task.find(params[:id])
    unless current_user.id == @task.user_id
      redirect_to tasks_path, notice: 'アクセスはできません'
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end
end