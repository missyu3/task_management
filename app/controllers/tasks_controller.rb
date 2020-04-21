class TasksController < ApplicationController
  before_action :find_params, only: [:edit, :update, :show, :destroy]

  PER = 5

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: I18n.t( :message_task_create, title: @task.title)
    else
      render "new"
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: I18n.t( :message_task_update, title: @task.title)
    else
      render "edit"
    end
  end

  def index
    tasks = Task.all
    @where = {title: nil, status: nil, priority: nil}
    if params[:sort]
      tasks = Task.all.title_include(params[:title]).status_equal(params[:status]).priority_equal(params[:priority])
      tasks = tasks.order_by(params[:column], params[:sort])
      @tasks = tasks.page(params[:page]).per(PER)
      @where = {title: params[:title], status: params[:status], priority: params[:priority]}
    elsif params[:title]
      tasks = Task.all.title_include(params[:title]).status_equal(params[:status]).priority_equal(params[:priority]).created_before
      @tasks = tasks.page(params[:page]).per(PER)
      @where = {title: params[:title], status: params[:status], priority: params[:priority]}
    else
      @tasks = tasks.created_before.page(params[:page]).per(PER)
    end
  end

  def show; end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: I18n.t( :message_task_delete, title: @task.title)
  end

  private
  def find_params
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :status, :limit, :priority, :user_id)
  end
end
