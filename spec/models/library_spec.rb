require 'rails_helper'

RSpec.describe Library, type: :model do
  context 'validation' do
    it 'should have valid attributes' do
      FactoryGirl.build(:library).should be_valid
    end

    it 'should not have empty name' do
      FactoryGirl.build(:library).should_not be_valid
    end

    it 'should not have empty address' do
      FactoryGirl.build(:library, address: '').should_not be_valid
    end

    it 'should not have empty phone number' do
      FactoryGirl.build(:library, phone: '').should_not be_valid
    end

    it 'should not have phone number length less than 10' do
      FactoryGirl.build(:library, phone: '1234').should_not be_valid
    end

    it 'should not have phone number greater less than 15' do
      FactoryGirl.build(:library, phone: '1234567890987654').should_not be_valid
    end
  end

  context 'association' do
    it 'should have many books' do
      library = FactoryGirl.create(:library)
      book1 = FactoryGirl.create(:book, library_id: library.id)
      book2 = FactoryGirl.create(:book, library_id: library.id)
      library.books.should include book1
      library.books.should include book2
    end

    it 'should not have many invalid books' do
      library1 = FactoryGirl.create(:library)
      library2 = FactoryGirl.create(:library)
      book1 = FactoryGirl.create(:book, library_id: library1.id)
      book2 = FactoryGirl.create(:book, library_id: library2.id)
      library1.books.should include book1
      library2.books.should include book2
      library1.books.should_not include book2
      library2.books.should_not include book1
    end

    it 'should have many members' do
      library = FactoryGirl.create(:library)
      member1 = FactoryGirl.create(:member, library_id: library.id)
      member2 = FactoryGirl.create(:member, library_id: library.id)
      library.members.should include member1
      library.members.should include member2
    end

    it 'should not have many invalid members' do
      library1 = FactoryGirl.create(:library)
      library2 = FactoryGirl.create(:library)
      member1 = FactoryGirl.create(:member, library_id: library1.id)
      member2 = FactoryGirl.create(:member, library_id: library2.id)
      library1.members.should include member1
      library2.members.should include member2
      library1.members.should_not include member2
      library2.members.should_not include member1
    end
  end
end