require 'rails_helper'

RSpec.describe LibrariesController, type: :controller do
	context 'GET#index' do
    it 'should show all libraries successfully' do
    	library1 = FactoryGirl.create(:library)
    	library2 = FactoryGirl.create(:library)
      get :index, format: 'json'
      assigns(:libraries).should include library1
      assigns(:libraries).should include library2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get library successfully' do
      library = FactoryGirl.create(:library)
      get :show, id: library.id, format: 'json'
      assigns(:library).should eq library
      response.should have_http_status(:ok)
    end

    it 'should not get invalid library' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new library successfully' do
      get :new, format: 'json'
      assigns(:library).id.should eq nil
      assigns(:library).name.should eq nil
      assigns(:library).address.should eq nil
      assigns(:library).phone_no.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct library successfully' do
      library = FactoryGirl.create(:library)
      get :edit, id: library.id,format: 'json'
      assigns(:library).should eq library
      response.should have_http_status(:ok)
    end

    it 'should not get library with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create library successfully' do
      library = FactoryGirl.create(:library)
      post :create, library: { name: library.name, address: library.address, phone_no: library.phone_no },format: 'json'
      assigns(:library).name.should eq library.name
      assigns(:library).address.should eq library.address
      assigns(:library).phone_no.should eq library.phone_no
      response.should have_http_status(:created)
    end

    it 'should not create library with invalid inputs' do
      post :create, library: { name: nil, address: nil, phone_no: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update library successfully' do
      library1 = FactoryGirl.create(:library)
      library2 = FactoryGirl.create(:library)
      put :update,id: library1.id, library: { name: library2.name, address: library2.address, phone_no: library2.phone_no },format: 'json'
      assigns(:library).id.should eq library1.id
      assigns(:library).name.should eq library2.name
      assigns(:library).address.should eq library2.address
      assigns(:library).phone_no.should eq library2.phone_no
      response.should have_http_status(:ok)
    end

    it 'should not update library with invalid inputs' do
      library = FactoryGirl.create(:library)
      put :update,id: library.id, library: { name: nil, address: nil, phone_no: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

   it 'should not update library with invalid library_id' do
      library = FactoryGirl.create(:library)
      put :update,id: '12345678', library: { name: library.name, address: library.address, phone_no: library.phone_no },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy library successfully' do
      library = FactoryGirl.create(:library)
      delete :destroy, id: library.id,format: 'json'
      assigns(:library).should eq library
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid library' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
