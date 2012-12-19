# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fitbit_account do
    request_token "requesttoken"
    request_secret "requestsecret"
    access_token "accesstoken"
    access_secret "accesssecret"
    verifier "verifiercode"
    fb_user_id "fitbituserid"
  end
end

