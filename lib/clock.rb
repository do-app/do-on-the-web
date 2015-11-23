Dir["/jobs/*.rb"].each { |f| require f }

require 'clockwork'

module Clockwork
  every(1.week, 'assign_chores.every_sunday', at ='Tuesday 00:00') do
    Household.all.each do |household| 
      AssignRemainingChoresJob.perform_later(household.id)
    end
  end
end
