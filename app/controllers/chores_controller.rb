class ChoresController < ApplicationController
  include AssignmentPeriod

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
    redirect_to @household and return unless belongs_to_household? @chore, @household
    validate_current_user_belongs_to_household (@household)
  end

  def update
    household = Household.find_by(id: params[:household_id])
    chore = Chore.find_by(id: params[:id])
    redirect_to household and return unless belongs_to_household? chore, household
    if validate_current_user_belongs_to_household (household)
      chore.update(chore_params)
      if chore.save
        #flash[:success] = "Chore updated!"
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
    redirect_to household and return unless belongs_to_household? chore, household
    if validate_current_user_belongs_to_household (household)
      if current_user.assigned_chores << chore
        flash[:success] = "#{chore.name} has been assigned to you."
        redirect_to household
      else 
        flash[:errors] = current_user.errors.full_messages
        redirect_to household
      end
    end
  end

  def complete
    assigned_chore = UserChore.where('created_at > ?', start_of_period).find_by(chore_id: params[:id], user_id: current_user.id)
    user = current_user
    if assigned_chore
      assigned_chore.completed = true
      user.points += assigned_chore.chore.points
      if assigned_chore.save && user.save
        flash[:success] = "You have completed '#{assigned_chore.chore.name}' for #{assigned_chore.chore.points}!"
      else
        flash[:errors] = user.errors.full_messages + assigned_chore.errors.full_messages
      end
    else
      flash[:error] = "No chore could be found!"
    end
    redirect_to :back
  end

  def destroy 
    household = Household.find_by(id: params[:household_id])
    chore = Chore.find_by(id: params[:id])
    redirect_to household and return unless belongs_to_household? chore, household
    if validate_current_user_belongs_to_household (household)
      if chore.destroy
        #flash[:success] = "Your chore was deleted!"
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
end
