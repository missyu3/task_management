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
      redirect_to user_path(@user)
    else
      render :new
    end 
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(current_user)
    else
      render :new
    end 
  end

  def destroy
    return unless params[:admin]
    user_id = @user.id
    if @user.destroy
      if user_id == current_user.id
        session[:user_id] = nil
        redirect_to new_session_path
      end
    end
    redirect_to admin_user_path(current_user)
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
    return if current_user.admin == true
    redirect_to user_path(current_user) unless @user && @user.id == current_user.id
  end

end