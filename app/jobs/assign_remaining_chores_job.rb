class AssignRemainingChoresJob < ActiveJob::Base
  queue_as :default

  def perform(household_id)
    household = Household.find_by(id: household_id)
    household.assign_remaining_chores
    household.save
  end
end
