class TasksController < ApplicationController
  def index
    @tasks = Task.all
    if params[:sort_deadline]
      @tasks = Task.deadline
    end
    if params[:sort_priority]
      @tasks = Task.order(priority: :asc)
    end
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if params[:task].present? && params[:task][:status].present?
        @tasks = Task.search_title(title).search_status(status)
      elsif params[:task].present?
        @tasks = Task.search_title(title)
      elsif params[:status].present?
        @tasks = Task.search_status(status)
      end
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

  # def search
  #   task.where('title LIKE(?)', "%#{params[:keyword]}%")
  # end

  private

  def task_params
    params.require(:task).permit(:title, :detail, :deadline_at, :status, :priority)
  end


end
