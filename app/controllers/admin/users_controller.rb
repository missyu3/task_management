class Admin::UsersController < ApplicationController
  before_action :find_user
  before_action :admin_required

  def update
    if @user.update(admin: true)
      redirect_to admin_user_path(current_user.id)
    else
      render :index
    end
  end

  def destroy
    if @user.update(admin: false)
      redirect_to admin_user_path(current_user.id)
    else
      render :index
    end
  end

  def show
    @users = User.all    
  end

  private 
  def find_user
    @user = User.find(params[:id])
  end

  def admin_required
    redirect_to user_path(current_user.id) unless current_user.admin
  end
end
