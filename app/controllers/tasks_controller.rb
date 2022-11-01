class TasksController < ApplicationController
  def index
    if params[:sort_deadline]
      @tasks = Task.deadline
    else
      @tasks = Task.all
      @tasks = @tasks.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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

  def search
    task.where('title LIKE(?)', "%#{params[:keyword]}%")
  end

  private

  def task_params
    params.require(:task).permit(:title, :detail, :deadline_at, :status)
  end


end
