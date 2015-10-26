class ChoresController < ApplicationController

  before_action :authenticate

  def new
    @household = Household.find_by(id: params[:household_id])
    if current_user.household == @household
      @chore = Chore.new
    else 
      flash[:error] = "You must be a member of this household to add a new chore!"
      if current_user.household
        redirect_to current_user.household
      else 
        redirect_to households_path
      end
    end
  end

  def create
    household = Household.find_by(id: params[:household_id])
    if current_user.household == household
      chore = Chore.new(chore_params)
      household.chores << chore
      if household.save
        flash[:success] = "Success! Chore created!"
      else 
        flash[:errors] = household.errors.full_messages
      end
      redirect_to household
    else
      flash[:error] = "You must be a member of this household to create a new chore"
      redirect_to root_path
    end
  end

  def edit
  end

  def update

  end

  def destroy 
  end

  private
  def chore_params
    params.require(:chore).permit(:name,
                                  :points,
                                  :length_of_time,
                                  :times_per_week)
  end
end
