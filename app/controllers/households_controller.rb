class HouseholdsController < ApplicationController

  before_action :authenticate

  def index
    @household = Household.new
  end

  def new
    @household = Household.new
  end

  def create
    if current_user.household
      flash[:error] = "You already belong to a household!"
      redirect_to current_user.household
    else
      household = Household.new(household_params)
      household.head_of_household = current_user
      if household.save
        flash[:success] = "Success! Household created!"
      else
        flash[:errors] = household.errors.full_messages
      end
      redirect_to household
    end
  end

  def show
    @household = Household.find_by(id: params[:id])
    redirect_to root_path and return unless household_exists? @household
    unless current_user.household == @household
      flash[:error] = "You must be a member of this household to view this page"
      redirect_to current_user
    end
  end

  def edit
    @household = Household.find_by(id: params[:id])
    redirect_to root_path and return unless household_exists? @household
    validate_current_user_is_head_of_household (@household)
  end

  def update
    household = Household.find_by(id: params[:id])
    redirect_to root_path and return unless household_exists? household
    if validate_current_user_is_head_of_household (household)
      household.update(household_params)
      if household.save
        flash[:success] = "Household updated!"
        redirect_to household
      else
        flash[:errors] = household.errors.full_messages
        redirect_to household
      end
    end
  end

  def join
    household = Household.find_by(id: params[:id])
    redirect_to root_path and return unless household_exists? household
    if current_user.household
      flash[:error] = "You may only join one household at a time."
      redirect_to current_user.household
    else
      user = current_user
      user.household = household
      if user.save
        flash[:success] = "You have successfully joined the #{household.name} household!"
      else
        flash[:errors] = household.errors.full_messages
      end
      redirect_to household
    end
  end

  def leave
    household = Household.find_by(id: params[:id])
    redirect_to root_path and return unless household_exists? household
    unless current_user.household == household
      flash[:error] = "You are not a member of this household"
      redirect_to household
    else
      user = current_user
      user.household = nil
      if user.save
        redirect_to user
      else
        flash[:errors] = user.errors.full_messages
        redirect_to household
      end
    end
  end

  def search
    if params[:search]
      @households = Household.search(params[:search]).order("created_at DESC")
    end
  end

  def destroy
    household = Household.find_by(id: params[:id])
    redirect_to root_path and return unless household_exists? household
    if validate_current_user_is_head_of_household (household)
      if household.destroy
        flash[:success] = "Your household was deleted"
      else
        flash[:errors] = household.errors.full_messages
      end
      redirect_to root_path
    end
  end

  private
  def household_params
    params.require(:household).permit(:name)
  end

  def household_exists? (household)
    if household
      true
    else
      flash[:error] = "Household could not be found"
      false
    end
  end

  def validate_current_user_is_head_of_household (household)
    if current_user != household.head_of_household
      flash[:error] = "You must be the head of household to make changes."
      redirect_to current_user and return
    else
      true
    end
  end
end
