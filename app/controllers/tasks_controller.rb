class TasksController < ApplicationController
  before_action :find_params, only: [:edit, :update, :show, :destroy]
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスク#{@task.title}の作成を行いました。"
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: I18n.t( :task_update, title: @task.title)
    else
      render "edit"
    end
  end

  def index
    @tasks = Task.all
  end

  def show; end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスク#{@task.title}の削除を行いました。"
  end

  private
  def find_params
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :status, :limit, :user_id)
  end

end
