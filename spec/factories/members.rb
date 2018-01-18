FactoryGirl.define do
	factory :member do
		library_id { FactoryGirl.create(:library).id }
		name Faker::Name.name
		address Faker::Address.street_name
		phone_no Faker::Number.number(10)
		gender 'male'
		code Faker::Number.number(5)
		validity_date Faker::Date.between(2.days.ago, Date.today).strftime("%F")
		is_author Faker::Boolean.boolean
	end
end