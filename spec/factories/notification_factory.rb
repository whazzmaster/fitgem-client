# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :notification do |f|
  f.user_id "MyString"
  f.body "MyText"
end
