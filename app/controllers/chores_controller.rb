class ChoresController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update

  end

  def destroy 
  end

  private
  def chore_params
    params.require(:chore).permit(:name,
                                  :points,
                                  :length_of_time,
                                  :times_per_week)
  end
end
