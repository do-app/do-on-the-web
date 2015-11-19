module AssignmentPeriod
  def start_of_period 
    Time.now.beginning_of_week - 1.days
  end
end