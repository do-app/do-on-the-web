# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    message "MyText"
    household ""
    origin ""
  end
end
