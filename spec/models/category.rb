require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validation' do
    it 'should have valid attributes' do
      FactoryGirl.build(:category).should be_valid
    end

    it 'should not have empty name' do
      FactoryGirl.build(:category, name: '').should_not be_valid
    end
  end

  context 'association' do

    it 'should have many books' do
      category = FactoryGirl.create(:category)
      book1 = FactoryGirl.create(:book, category_id: category.id)
      book2 = FactoryGirl.create(:book, category_id: category.id)
      category.books.should include book1
      category.books.should include book2
    end

    it 'should not have many invalid issue histories' do
      category1 = FactoryGirl.create(:category)
      category2 = FactoryGirl.create(:category)
      book1 = FactoryGirl.create(:book, category_id: category1.id)
      book2 = FactoryGirl.create(:book, category_id: category2.id)
      category1.books.should include book1
      category2.books.should include book2
      category1.books.should_not include book2
      category2.books.should_not include book1
    end
  end
end