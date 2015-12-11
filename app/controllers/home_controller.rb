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
  
end
