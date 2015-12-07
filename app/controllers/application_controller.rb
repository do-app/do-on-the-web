class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def current_user
    User.find_by(id: session[:user_id])
  end

  def is_authenticated?
    !!session[:user_id]
  end

  def authenticate
    unless is_authenticated? 
      flash[:errors] = ["You must be logged in to perform this action"]
      redirect_to root_path
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

  def belongs_to_household? (item, household)
    if item.household != household
      flash[:error] = "#{item.name} does not belong to household"
      false
    else 
      true
    end
  end
end
