require 'rails_helper'

RSpec.describe Member, type: :model do
  context 'validation' do
    it 'should have valid attributes' do
      FactoryGirl.build(:member, gender:'male').should be_valid
    end

    it 'should not have empty name' do
      FactoryGirl.build(:member, name: '').should_not be_valid
    end

    it 'should not have empty code' do
      FactoryGirl.build(:member, code: '').should_not be_valid
    end

    it 'should not have empty address' do
      FactoryGirl.build(:member, address: '').should_not be_valid
    end

    it 'should not have empty gender' do
      FactoryGirl.build(:member, gender: '').should_not be_valid
    end

    it 'should not have invalid gender' do
      FactoryGirl.build(:member, gender: 'asdfghj').should_not be_valid
    end

    it 'should not have empty phone_no' do
      FactoryGirl.build(:member, phone_no: '').should_not be_valid
    end

    it 'should not have phone number length less than 10' do
      FactoryGirl.build(:member, phone_no: '1234').should_not be_valid
    end

    it 'should not have phone number greater less than 15' do
      FactoryGirl.build(:member, phone_no: '1234567890987654').should_not be_valid
    end

    it 'should not have empty validity_date' do
      FactoryGirl.build(:member, validity_date: '').should_not be_valid
    end

    it 'should not have invalid validity_date' do
      FactoryGirl.build(:member, validity_date: 'asdfg').should_not be_valid
    end

    it 'should not have empty library id' do
      FactoryGirl.build(:member, library_id: '').should_not be_valid
    end

    it 'should not have invalid library id' do
      FactoryGirl.build(:member, library_id: 'a').should_not be_valid
    end
  end

  context 'association' do
    it 'should belong to library' do
      library = FactoryGirl.create(:library)
      member = FactoryGirl.create(:member, library_id: library.id)
      member.library.should eq library
    end

    it 'should not belong to invalid library' do
      library1 = FactoryGirl.create(:library)
      library2 = FactoryGirl.create(:library)
      member = FactoryGirl.create(:member, library_id: library1.id)
      member.library.should eq library1
      member.library.should_not eq library2
    end

    it 'should have many issue histories' do
      member = FactoryGirl.create(:member)
      issueHistory1 = FactoryGirl.create(:issue_history, member_id: member.id)
      issueHistory2 = FactoryGirl.create(:issue_history, member_id: member.id)
      member.issue_histories.should include issueHistory1
      member.issue_histories.should include issueHistory2
    end

    it 'should not have many invalid issue histories' do
      member1 = FactoryGirl.create(:member)
      member2 = FactoryGirl.create(:member)
      issueHistory1 = FactoryGirl.create(:issue_history, member_id: member1.id)
      issueHistory2 = FactoryGirl.create(:issue_history, member_id: member2.id)
      member1.issue_histories.should include issueHistory1
      member2.issue_histories.should include issueHistory2
      member1.issue_histories.should_not include issueHistory2
      member2.issue_histories.should_not include issueHistory1
    end
  end
end