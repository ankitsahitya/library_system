require 'rails_helper'

RSpec.describe MembersController, type: :controller do
	context 'GET#index' do
    it 'should show all members successfully' do
    	member1 = FactoryGirl.create(:member)
    	member2 = FactoryGirl.create(:member)
      get :index, format: 'json'
      assigns(:members).should include member1
      assigns(:members).should include member2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get member successfully' do
      member = FactoryGirl.create(:member)
      get :show, id: member.id, format: 'json'
      assigns(:member).should eq member
      response.should have_http_status(:ok)
    end

    it 'should not get invalid member' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new member successfully' do
      get :new, format: 'json'
      assigns(:member).id.should eq nil
      assigns(:member).library_id.should eq nil
      assigns(:member).name.should eq nil
      assigns(:member).address.should eq nil
      assigns(:member).phone_no.should eq nil
      assigns(:member).gender.should eq nil
      assigns(:member).code.should eq nil
      assigns(:member).validity_date.should eq nil
      assigns(:member).is_author.should eq false
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct member successfully' do
      member = FactoryGirl.create(:member)
      get :edit, id: member.id,format: 'json'
      assigns(:member).should eq member
      response.should have_http_status(:ok)
    end

    it 'should not get member with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create member successfully' do
      member = FactoryGirl.create(:member)
      post :create, member: { name: member.name, address: member.address, phone_no: member.phone_no, library_id: member.library_id, gender: member.gender, code: member.code, validity_date: member.validity_date, is_author: member.is_author },format: 'json'
      assigns(:member).name.should eq member.name
      assigns(:member).address.should eq member.address
      assigns(:member).phone_no.should eq member.phone_no
      assigns(:member).library_id.should eq member.library_id
      assigns(:member).gender.should eq member.gender
      assigns(:member).code.should eq member.code
      assigns(:member).validity_date.should eq member.validity_date
      assigns(:member).is_author.should eq member.is_author
      response.should have_http_status(:created)
    end

    it 'should not create member with invalid inputs' do
      post :create, member: { name: nil, address: nil, phone_no: nil, library_id: nil, gender: nil, code: nil, validity_date: nil, is_author: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create member with invalid library_id' do
      member = FactoryGirl.create(:member)
      post :create, member: { name: member.name, address: member.address, phone_no: member.phone_no, library_id: '1234', gender: member.gender, code: member.code, validity_date: member.validity_date, is_author: member.is_author },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update member successfully' do
      member1 = FactoryGirl.create(:member)
      member2 = FactoryGirl.create(:member)
      put :update,id: member1.id, member: { name: member2.name, address: member2.address, phone_no: member2.phone_no, library_id: member2.library_id, gender: member2.gender, code: member2.code, validity_date: member2.validity_date, is_author: member2.is_author },format: 'json'
      assigns(:member).id.should eq member1.id
      assigns(:member).name.should eq member2.name
      assigns(:member).address.should eq member2.address
      assigns(:member).phone_no.should eq member2.phone_no
      assigns(:member).library_id.should eq member2.library_id
      assigns(:member).gender.should eq member2.gender
      assigns(:member).code.should eq member2.code
      assigns(:member).validity_date.should eq member2.validity_date
      assigns(:member).is_author.should eq member2.is_author
      response.should have_http_status(:ok)
    end

    it 'should not update member with invalid inputs' do
      member = FactoryGirl.create(:member)
      put :update,id: member.id, member: { name: nil, address: nil, phone_no: nil, library_id: nil, gender: nil, code: nil, validity_date: nil, is_author: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update member with invalid member_id' do
      member = FactoryGirl.create(:member)
      put :update,id: '12345678', member: { name: member.name, address: member.address, phone_no: member.phone_no, library_id: member.library_id, gender: member.gender, code: member.code, validity_date: member.validity_date, is_author: member.is_author },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update member with invalid library_id' do
      member1 = FactoryGirl.create(:member)
      member2 = FactoryGirl.create(:member)
      put :update,id: member1.id, member: { name: member2.name, address: member2.address, phone_no: member2.phone_no, library_id: '1234', gender: member2.gender, code: member2.code, validity_date: member2.validity_date, is_author: member2.is_author },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy member successfully' do
      member = FactoryGirl.create(:member)
      delete :destroy, id: member.id,format: 'json'
      assigns(:member).should eq member
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid member' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
