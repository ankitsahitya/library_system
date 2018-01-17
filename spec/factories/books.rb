FactoryGirl.define do
  factory :book do
  	library_id { FactoryGirl.create(:library).id }
  	category_id { FactoryGirl.create(:category).id }
  	name Faker::Book.title
    author Faker::Book.author
    code Faker::Code.isbn
    price Faker::Number.decimal(2)
    publication Faker::Book.publisher
    version Faker::Number.number(1)
    no_of_copies Faker::Number.number(2)
  end
end