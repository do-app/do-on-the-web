class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :points, :household_id)
  end

end
