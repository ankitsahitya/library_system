require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'validation' do
    it 'should have valid attributes' do
      FactoryGirl.build(:book).should be_valid
    end

    it 'should not have empty name' do
      FactoryGirl.build(:book, name: '').should_not be_valid
    end

    it 'should not have empty author' do
      FactoryGirl.build(:book, author: '').should_not be_valid
    end

    it 'should not have empty code' do
      FactoryGirl.build(:book, code: '').should_not be_valid
    end

    it 'should not have empty price' do
      FactoryGirl.build(:book, price: '').should_not be_valid
    end

    it 'should not have invalid price' do
      FactoryGirl.build(:book, price: 'asdfgh').should_not be_valid
    end

    it 'should not have empty publication' do
      FactoryGirl.build(:book, publication: '').should_not be_valid
    end

    it 'should not have empty version' do
      FactoryGirl.build(:book, version: '').should_not be_valid
    end

    it 'should not have invalid no. of copies' do
      FactoryGirl.build(:book, no_of_copies: 'asdfgh').should_not be_valid
    end

    it 'should not have empty library id' do
      FactoryGirl.build(:book, library_id: '').should_not be_valid
    end

    it 'should not have invalid library id' do
      FactoryGirl.build(:book, library_id: 'a').should_not be_valid
    end

    it 'should not have empty category id' do
      FactoryGirl.build(:book, category_id: '').should_not be_valid
    end

    it 'should not have invalid category id' do
      FactoryGirl.build(:book, category_id: 'a').should_not be_valid
    end
  end

  context 'association' do
    it 'should belong to library' do
      library = FactoryGirl.create(:library)
      book = FactoryGirl.create(:book, library_id: library.id)
      book.library.should eq library
    end

    it 'should not belong to invalid library' do
      library1 = FactoryGirl.create(:library)
      library2 = FactoryGirl.create(:library)
      book = FactoryGirl.create(:book, library_id: library1.id)
      book.library.should eq library1
      book.library.should_not eq library2
    end

    it 'should belong to category' do
      category = FactoryGirl.create(:category)
      book = FactoryGirl.create(:book, category_id: category.id)
      book.category.should eq category
    end

    it 'should not belong to invalid category' do
      category1 = FactoryGirl.create(:category)
      category2 = FactoryGirl.create(:category)
      book = FactoryGirl.create(:book, category_id: category1.id)
      book.category.should eq category1
      book.category.should_not eq category2
    end

    it 'should have many issue histories' do
      book = FactoryGirl.create(:book)
      issueHistory1 = FactoryGirl.create(:issue_history, book_id: book.id)
      issueHistory2 = FactoryGirl.create(:issue_history, book_id: book.id)
      book.issue_histories.should include issueHistory1
      book.issue_histories.should include issueHistory2
    end

    it 'should not have invalid issue histories' do
      book1 = FactoryGirl.create(:book)
      book2 = FactoryGirl.create(:book)
      issueHistory1 = FactoryGirl.create(:issue_history, book_id: book1.id)
      issueHistory2 = FactoryGirl.create(:issue_history, book_id: book2.id)
      book1.issue_histories.should include issueHistory1
      book2.issue_histories.should include issueHistory2
      book1.issue_histories.should_not include issueHistory2
      book2.issue_histories.should_not include issueHistory1
    end
  end
end