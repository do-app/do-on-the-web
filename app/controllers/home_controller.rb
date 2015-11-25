class HomeController < ApplicationController
  def index
  	unless is_authenticated?
  		redirect_to new_session_path
  	else
  		unless current_user.household
  			redirect_to households_path
  		end
    end
  end
end
