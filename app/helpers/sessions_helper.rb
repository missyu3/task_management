module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    current_user.present?
  end

  def current_user?(user_id)
    current_user.id == user_id
  end
end
