class TasksController < ApplicationController
  before_action :find_params, only: [:edit, :update, :show, :destroy]

  PER = 5

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: I18n.t("message.task_create", title: @task.title)
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: I18n.t("message.task_update", title: @task.title)
    else
      render "edit"
    end
  end

  def index
    tasks = Task.all
    params_task = params[:task]
    tasks.search_index(params_task[:title],params_task[:status],params_task[:priority]) if params_task
    if params[:sort]
      tasks = tasks.order_by(params[:column], params[:sort])
    else
      tasks = tasks.created_before
    end
    @tasks = tasks.page(params[:page]).per(PER)
    @where = {title: nil, status: nil, priority: nil}
    @where = params_task if params_task
    #form_withに与える引数はTaskクラスにしないと文言の変換が行われないため、@task = Task.newする。
    @task = Task.new
  end

  def show; end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: I18n.t("message.task_delete", title: @task.title)
  end

  private
  def find_params
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :status, :limit, :priority, :user_id)
  end
end
