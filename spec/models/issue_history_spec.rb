require 'rails_helper'

RSpec.describe IssueHistory, type: :model do
  context 'validation' do
    it 'should have valid attributes' do
      FactoryGirl.build(:issue_history).should be_valid
    end

    it 'should not have empty type of book' do
      FactoryGirl.build(:issue_history, type_of_book: '').should_not be_valid
    end

    it 'should not have invalid type of book' do
      FactoryGirl.build(:issue_history, type_of_book: 'asdfgh').should_not be_valid
    end

    it 'should not have empty issue date' do
      FactoryGirl.build(:issue_history, issue_date: '').should_not be_valid
    end

    it 'should not have invalid issue date' do
      FactoryGirl.build(:issue_history, issue_date: 'asdfgh').should_not be_valid
    end

    it 'should not have invalid no. of copies' do
      FactoryGirl.build(:book, no_of_copies: 'asdfgh').should_not be_valid
    end

    it 'should not have invalid return date' do
      FactoryGirl.build(:issue_history, return_date: 'asdfgh').should_not be_valid
    end

    it 'should not have empty member id' do
      FactoryGirl.build(:issue_history, member_id: '').should_not be_valid
    end

    it 'should not have empty book id' do
      FactoryGirl.build(:issue_history, book_id: '').should_not be_valid
    end

    it 'should not have invalid member id' do
      FactoryGirl.build(:issue_history, member_id: 'asdfg').should_not be_valid
    end

    it 'should not have invalid book id' do
      FactoryGirl.build(:issue_history, book_id: 'asdfg').should_not be_valid
    end
  end

  context 'association' do
    it 'should belong to member' do
      member = FactoryGirl.create(:member)
      issueHistory = FactoryGirl.create(:issue_history, member_id: member.id)
      issueHistory.member.should eq member
    end

    it 'should not belong to invalid member' do
      member1 = FactoryGirl.create(:member)
      member2 = FactoryGirl.create(:member)
      issueHistory = FactoryGirl.create(:issue_history, member_id: member1.id)
      issueHistory.member.should eq member1
      issueHistory.member.should_not eq member2
    end

    it 'should belong to book' do
      book = FactoryGirl.create(:book)
      issueHistory = FactoryGirl.create(:issue_history, book_id: book.id)
      issueHistory.book.should eq book
    end

    it 'should not belong to invalid book' do
      book1 = FactoryGirl.create(:book)
      book2 = FactoryGirl.create(:book)
      issueHistory = FactoryGirl.create(:issue_history, book_id: book1.id)
      issueHistory.book.should eq book1
      issueHistory.book.should_not eq book2
    end
  end
end