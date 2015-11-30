class HomeController < ApplicationController
  def index
	if !session[:user_id]
		redirect_to "/sessions/new"
	else
		if !current_user.household
			redirect_to "/households"
		end
        end
  end
  
  def assign_chores
	current_user.household.chores.each do |chore|
		#current_user.household.members.sample(1).assign_household_chore(chore)
		chore.assign
	end
  end
  
  helper_method :assign_chores
  
end
