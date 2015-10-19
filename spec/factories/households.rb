FactoryGirl.define do 
  factory :household do 
    name { Faker::Internet.name }
  end
end