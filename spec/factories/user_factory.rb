FactoryGirl.define do
  factory :user do
    email "regularuser@test.com"
    password "regularguypassword"
    password_confirmation "regularguypassword"
    association :fitbit_account
  end
end

