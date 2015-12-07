class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
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

  # GET /users/1
  # GET /users/1.json
  def show
	redirect_to "/home/index"
  end

  # GET /users/new
  def new
    #if already logged in, go to homepage
    if session[:user_id]
     redirect_to "/home/index"
    end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:password]
      @user.password = params[:user][:password]
    end
    if @user.update(user_params)
      flash[:success] = "Your account has been updated!"
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.destroy
      session.delete(:user_id)
      redirect_to root_path
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :email_confirmation, :points, :household_id)
  end

 
end
