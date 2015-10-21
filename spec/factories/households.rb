FactoryGirl.define do 
  factory :household do 
    name { Faker::Internet.name }

    factory :invalid_household do 
      name nil
    end
  end
end