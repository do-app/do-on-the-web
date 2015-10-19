class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.password = params[:user][:password]
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Success! Account created!"
      redirect_to households_path
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    user = User.find_by(id: params[:id])
    user.update(user_paras)
    if user.save
      flash[:success] = "Success! Your account has been updated!"
      redirect_to user
    else
      flash[:errors] = user.errors.full_messages
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user.destroy
      session.delete(:user_id)
      flash[:success] = "Goodbye!"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :points, :household_id)
  end

end
