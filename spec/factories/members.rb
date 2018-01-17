FactoryGirl.define do
	factory :member do
		library_id { FactoryGirl.create(:library).id }
		name Faker::Name.name
		address Faker::Address.street_name
		phone_no Faker::Number.number(10)
		gender 'male'
		code Faker::Number.number(5)
		validity_date Date.new(Faker::Number.between(2000, 2020), Faker::Number.between(1, 31), Faker::Number.between(1, 12))
		is_author Faker::Boolean.boolean
	end
end