class HomeController < ApplicationController
  def index
    if current_user.household
      redirect_to current_user.household
    end
  end
end
