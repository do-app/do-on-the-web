class RewardsController < ApplicationController
  before_action :authenticate

  def new
    @household = Household.find_by(id: params[:household_id])
    if validate_current_user_belongs_to_household (@household)
      @reward = Reward.new
    end
  end

  def create
    household = Household.find_by(id: params[:household_id])
    if validate_current_user_belongs_to_household (household)
      reward = Reward.new(reward_params)
      household.rewards << reward
      if household.save
        flash[:success] = "Success! Reward created!"
      else 
        flash[:errors] = household.errors.full_messages
      end
      redirect_to household
    end
  end

  def edit
    @household = Household.find_by(id: params[:household_id])
    @reward = Reward.find_by(id: params[:id])
    redirect_to @household and return unless belongs_to_household? @reward, @household
    validate_current_user_belongs_to_household (@household)
  end

  def update 
    household = Household.find_by(id: params[:household_id])
    reward = Reward.find_by(id: params[:id])
    redirect_to household and return unless belongs_to_household? reward, household
    if validate_current_user_belongs_to_household (household)
      reward.update(reward_params)
      if reward.save
        flash[:success] = "Reward updated!"
        redirect_to household
      else 
        flash[:errors] = reward.errors.full_messages
        redirect_to household
      end
    end
  end

  def claim
    household = Household.find_by(id: params[:household_id])
    reward = Reward.find_by(id: params[:id])
    user = current_user
    redirect_to household and return unless belongs_to_household? reward, household
    if user.points < reward.points
      flash[:error] = "You don't have enough points to claim this reward"
      redirect_to :back
    end
    if validate_current_user_belongs_to_household (household)
      if user.claimed_rewards << reward
        user.points -= reward.points
        if user.save
          flash[:success] = "You have claimed your reward: #{reward.name} for #{reward.points} points!"
          redirect_to :back
        else
          flash[:errors] = user.errors.full_messages
        end
      else 
        flash[:errors] = user.errors.full_messages
        redirect_to :back
      end
    end  
  end

  def destroy 
    household = Household.find_by(id: params[:household_id])
    reward = Reward.find_by(id: params[:id])
    redirect_to household and return unless belongs_to_household? reward, household
    if validate_current_user_belongs_to_household (household)
      if reward.destroy
        flash[:success] = "Your reward was deleted!"
        redirect_to household
      else
        flash[:errors] = reward.errors.full_messages
        redirect_to household
      end
    end
  end

  private
  def reward_params
    params.require(:reward).permit(:name, :points, :household_id)
  end

end
