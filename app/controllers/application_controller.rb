class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  def is_authenticated?
    !!session[:user_id]
  end

  def authenticate
    unless is_authenticated? 
      flash[:errors] = ["You must be logged in to perform this action"]
      redirect_to root_path
    end
  end
end
