class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenicate(params[:password])
      session[:user_id] = user.id 
      flash[:success] = "Hello, #{user.name}!"
      redirect_to user_path(user)
    else 
      flash[:errors] = ["Invalid password or email address"]
      redirect_to new_session_path
    end
  end

  def destroy
    if session.delete(:user_id)
      flash[:notice] = "Goodbye!"
      redirect_to :root
    else
      flash[:error] = "Something went wrong with your logout"
      redirect_to :back
    end
  end
end
