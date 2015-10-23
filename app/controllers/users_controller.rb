class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def create
    user = User.new(user_params)
    user.password = params[:user][:password]
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Success! Account created!"
      redirect_to user
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
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

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
        session[:user_id] = @user.id
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
	    session.delete(:user_id)
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :email_confirmation,  :password, :password_confirmation, :points, :household_id)
  end

end
