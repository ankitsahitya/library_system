FactoryGirl.define do
  factory :library do
  	name Faker::Name.name
  	address Faker::Address.street_name
  	phone_no Faker::Number.number(10)
  end
end