class Admin::UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy, :show]
  before_action :admin_required

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(current_user)
    else
      render :new
    end
  end

  def update
    @user.admin = params[:admin]
    if @user.save(validate: false)
      redirect_to admin_user_path(current_user)
    else
      @users = User.all.includes(:tasks)
      render :show
    end
  end

  def show
    @users = User.all.id_asc.includes(:tasks)
  end

  private 
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:admin).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def admin_required
    redirect_to user_path(current_user) unless current_user.admin?
  end
end
