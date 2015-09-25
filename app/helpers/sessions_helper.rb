module SessionsHelper
  def is_authenticated? 
    !!session[:user_id]
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def is_current_user?(user)
    user && session[:user_id] == user.id
  end
end