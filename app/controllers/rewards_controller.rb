class RewardsController < ApplicationController
  before_action :authenticate

  def new
  end

  def create
  end

  def edit 
  end

  def update 
  end

  def claim
  end

  def destroy 
  end

  private
  def reward_params
    params.require(:reward).permit(:name, :points, :household_id)
  end

end
