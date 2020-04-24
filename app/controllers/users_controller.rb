class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new 
    if current_user
      redirect_to user_path(current_user.id)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(get_parms)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end 
  end

  def show
    @user = User.find(params[:id])
  end
  private 
  def get_parms
    params.require(:user).permit(:name, :email, :image, :profile, :password, :password_confirmation)
  end
end
