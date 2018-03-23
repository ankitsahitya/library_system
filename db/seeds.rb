require 'faker'
20.times do
	Library.create(name: Faker::Name.name, address: Faker::Address.street_name, phone_no: Faker::Number.number(10))	
end