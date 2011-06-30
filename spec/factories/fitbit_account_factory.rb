# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :fitbit_account do |f|
  f.request_token "requesttoken"
  f.request_secret "requestsecret"
  f.access_token "accesstoken"
  f.access_secret "accesssecret"
  f.verifier "verifiercode"
  f.fb_user_id "fitbituserid"
end
