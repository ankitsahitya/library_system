FactoryGirl.define do
	factory :issue_history do
		member_id { FactoryGirl.create(:member).id }
		book_id { FactoryGirl.create(:book).id }
		type_of_book %w[rent return].sample
		no_of_copies Faker::Number.number(2)
    return_date Faker::Date.between(2.days.ago, Date.today).strftime("%F")
		issue_date Faker::Date.between(5.days.ago, Date.today).strftime("%F")
	end
end