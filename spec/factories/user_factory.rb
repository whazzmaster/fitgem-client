Factory.define :user do |u|
  u.email "regularuser@test.com"
  u.password "regularguypassword"
  u.password_confirmation "regularguypassword"  
  u.association :fitbit_account
end
