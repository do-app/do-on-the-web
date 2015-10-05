CHORES = {
  # Chore name => [points, times_per_week]
  "Do the laundry" => [100,1,60],
  "Walk the dog" => [5, 7, 15],
  "Feed the fish" => [10, 3,5],
  "Clean the bathroom" => [150, 1,30],
  "Do the dishes" => [5, 14,10], 
  "Vacuum" => [100, 2,45], 
  "Mop" => [100, 2,45], 
  "Feed the dog" => [2, 14,5], 
  "Do the grocery shopping" => [100, 1,90], 
  "Clean the kitchen" => [100, 3,30], 
  "Clean the toilet" => [200, 1,15], 
  "Wipe down the counter" => [50, 7,10], 
  "Make the bed" => [10, 7,5]
}

20.times do 
  u = User.new(
      name: Faker::Name.name,
      email: Faker::Internet.email
    )
  u.password = "password"
  u.save
end

5.times do |user_id|
  household = Household.create(
      name: Faker::Team.name,
      head_of_household_id: user_id + 1
    )
  CHORES.keys.each do |chore_name|
    household.chores << Chore.create(
                              name: CHORES[chore_name],
                              points: CHORES[chore_name][0],
                              times_per_week: CHORES[chore_name][1], 
                              length_of_time: CHORES[chore_name][2]
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
    chores = user.household.chores.sample(4)
    chores.each do |chore| 
      user.chores << chore
    end
  end
end
