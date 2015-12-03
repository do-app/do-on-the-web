class ChoresController < ApplicationController

  before_action :authenticate

  def verify
    @chore = Chore.find_by(id: params[:chore_id])
	@chore.status = "complete"
	@chore.save
	@chore.user.points = @chore.user.points + @chore.points
	@chore.user.save
	redirect_to(:back)
  end
  
  def unverify
	@chore = Chore.find_by( id: params[:chore_id])
	@chore.status = "incomplete"
    @chore.save
	redirect_to(:back)
  end
  
  def request_verification
	@chore = Chore.find_by( id: params[:chore_id])
	@chore.status = "waiting"
	@chore.save
	redirect_to(:back)
  end
  
  #helper_method :verify
  
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
	  chore.length_of_time = 0
	  chore.times_per_week = 0
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

  def assign
    household = Household.find_by(id: params[:household_id])
    chore = Chore.find_by(id: params[:id])
    redirect_to household and return unless chore_belongs_to_household? chore, household
    if validate_current_user_belongs_to_household (household)
      if current_user.chores << chore
        flash[:success] = "#{chore.name} has been assigned to you."
        redirect_to household
      else 
        flash[:errors] = current_user.errors.full_messages
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
