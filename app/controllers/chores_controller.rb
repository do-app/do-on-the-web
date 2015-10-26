class ChoresController < ApplicationController

  before_action :authenticate

  def new
    @household = Household.find_by(id: params[:household_id])
    if validate_current_user_belongs_to_household (@household)
      @chore = Chore.new
    end
  end

  def create
    household = Household.find_by(id: params[:household_id])
    if validate_current_user_belongs_to_household (household)
      chore = Chore.new(chore_params)
      household.chores << chore
      if household.save
        flash[:success] = "Success! Chore created!"
      else 
        flash[:errors] = household.errors.full_messages
      end
      redirect_to household
    end
  end

  def edit
    @household = Household.find_by(id: params[:household_id])
    @chore = Chore.find_by(id: params[:id])
    redirect_to @household and return unless chore_belongs_to_household? @chore, @household
    validate_current_user_belongs_to_household (@household)
  end

  def update
    household = Household.find_by(id: params[:household_id])
    chore = Chore.find_by(id: params[:id])
    redirect_to household and return unless chore_belongs_to_household? chore, household
    if validate_current_user_belongs_to_household (household)
      chore.update(chore_params)
      if chore.save
        flash[:success] = "Chore updated!"
        redirect_to household
      else 
        flash[:errors] = chore.errors.full_messages
        redirect_to household
      end
    end
  end

  def destroy 
    household = Household.find_by(id: params[:household_id])
    chore = Chore.find_by(id: params[:id])
    redirect_to household and return unless chore_belongs_to_household? chore, household
    if validate_current_user_belongs_to_household (household)
      if chore.destroy
        flash[:success] = "Your chore was deleted!"
        redirect_to household
      else
        flash[:errors] = chore.errors.full_messages
        redirect_to household
      end
    end
  end

  private
  def chore_params
    params.require(:chore).permit(:name,
                                  :points,
                                  :length_of_time,
                                  :times_per_week)
  end

  def chore_belongs_to_household? (chore, household)
    if chore.household != household
      flash[:error] = "Invalid chore"
      false
    else 
      true
    end
  end

  def validate_current_user_belongs_to_household (household)
    if current_user.household != household
      flash[:error] = "You must be a member of this household to edit this chore."
      redirect_to (current_user.household ? current_user.household : households_path) and return
    else
      true
    end
  end
end
