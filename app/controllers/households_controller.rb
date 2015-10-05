class HouseholdsController < ApplicationController

  before_action :authenticate

  def new
    @household = Household.new
  end

  def create
    household = Household.new(household_params)
    household.head_of_household = current_user
    if household.save
      flash[:success] = "Success! Household created!"
      redirect_to household
    else
      flash[:errors] = household.errors.full_messages
    end
  end

  def show
    @household = find_by_id_or_error(params[:id])
    unless current_user.household == @household
      flash[:errors] = "You must be a member of this household to view this page"
    end
  end

  def edit
    @household = find_by_id_or_error(params[:id])
    if current_user == @household.head_of_household
      @household.update(household_params)
    else
      flash[:errors] = ["You must be the head of household to make changes."]
    end
  end

  def update
    household = find_by_id_or_error(params[:id])
    if current_user == household.head_of_household
      household.update(household_params)
    else
      flash[:errors] = ["You must be the head of household to make changes."]
    end
    if household.save
      flash[:success] = "Household updated!"
    else
      flash[:errors] = household.errors.full_messages
    end
    redirect_to household
  end

  def join
    household = find_by_id_or_error(params[:id])
    current_user.household = household
    if current_user.save
      flash[:success] = "You have successfully joined the #{household.name} household!"
    else
      flash[:errors] = household.errors.full_messages
    end
    redirect_to household
  end

  def search 
    household = Household.find_by(name: params[:name])
    if household
      redirect_to household
    else
      redirect_to back
    end
  end

  def destroy
    household = find_by_id_or_error(params[:id])
    unless current_user == household.head_of_household
      flash[:errors] = ["You must be the head of household to make changes."]
      redirect_to household
    end
    if household.destroy
      flash[:success] = "Your household was deleted"
    else
      flash[:errors] = household.errors.full_messages
    end
    redirect_to root
  end

  private
  def household_params
    params.require(:household).permit(:name)
  end

  def find_by_id_or_error(id)
    household = Household.find_by(id: id)
    unless household
      flash[:errors] = ["Household could not be found"]
      redirect_to root_path and return
    end
  end
end
