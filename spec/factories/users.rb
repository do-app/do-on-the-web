FactoryGirl.define do 
  factory :user do 
    name { Faker::Internet.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
  end
end