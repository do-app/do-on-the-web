CHORES = {
  # Chore name => [points, times_per_week]
  "Do the laundry" => [100,1],
  "Walk the dog" => [5, 7],
  "Feed the fish" => [10, 3],
  "Clean the bathroom" => [150, 1],
  "Do the dishes" => [5, 14], 
  "Vacuum" => [100, 2], 
  "Mop" => [100, 2], 
  "Feed the dog" => [2, 14], 
  "Do the grocery shopping" => [100, 1], 
  "Clean the kitchen" => [100, 3], 
  "Clean the toilet" => [200, 1], 
  "Wipe down the counter" => [50, 7], 
  "Make the bed" => [10, 7]
}

20.times do 
  User.create(
      name: Faker::Name.name,
      email: Faker::Internet.email
    )
end

5.times do |user_id|
  household = Household.create(
      name: Faker::Team.name,
      head_of_household_id: user_id + 1
    )
  CHORES.keys.each do |chore_name| 
    household.chores << Chore.new(
                              name: CHORES[chore_name],
                              points: CHORES[chore_name][0],
                              times_per_week: CHORES[chore_name][1]
                            )
  end
  household.save
end

NUM_HOUSEHOLDS = Household.count

User.all.each do |user|
  unless user.household
    user.household_id = rand(1..NUM_HOUSEHOLDS-1)
    user.save
  end
  rand(1..3).times do 
    user.chores << user.household.chores.sample
  end
end
