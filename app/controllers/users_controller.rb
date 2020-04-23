class UsersController < ApplicationController
  def new 
    @user = User.new
  end

  def create
    @user = User.new(get_parms)
    if @user.save
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
