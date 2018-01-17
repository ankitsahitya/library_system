FactoryGirl.define do
	factory :issue_history do
		member_id { FactoryGirl.create(:member).id }
		book_id { FactoryGirl.create(:book).id }
		issue_type %i[rent return].sample
    return_date Date.new(Faker::Number.between(2000, 2020), Faker::Number.between(1, 31), Faker::Number.between(1, 12))
		issue_date Date.new(Faker::Number.between(2000, 2020), Faker::Number.between(1, 31), Faker::Number.between(1, 12))
	end