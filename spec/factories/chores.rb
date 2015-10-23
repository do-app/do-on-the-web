FactoryGirl.define do 
  factory :chore do 
    name { Faker::Lorem.sentence }
    points { rand(1..10) }
    length_of_time { [15, 30, 45, 60, 90].sample }
    times_per_week { rand(1..7) }

    factory :invalid_chore do 
      name nil
      points 0
      length_of_time 0
      times_per_week 0
    end

  end
end