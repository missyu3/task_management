class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :user_find, only: [:edit,:update, :show, :destroy]
  before_action :current_user_action_only, only: [:show]

  def new 
    if current_user
      redirect_to new_user_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end 
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(current_user.id)
    else
      render :new
    end 
  end

  def destroy
    if params[:admin]
      if @user.destroy
        @users = User.all    
        render "admin/users/show"
      else
        @users = User.all    
        render "admin/users/show"
      end
    end
  end

  def show; end
  def edit; end

  private 
  def user_params
    params.require(:user).permit(:name, :email,:admin, :password, :password_confirmation)
  end

  def user_find
    @user = User.find_by(id: params[:id])
  end
  
  def current_user_action_only
    redirect_to user_path(current_user.id) unless @user.id == current_user.id
  end

end