require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
	context 'GET#index' do
    it 'should show all categories successfully' do
    	category1 = FactoryGirl.create(:category)
    	category2 = FactoryGirl.create(:category)
      get :index, format: 'json'
      assigns(:categories).should include category1
      assigns(:categories).should include category2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get category successfully' do
      category = FactoryGirl.create(:category)
      get :show, id: category.id, format: 'json'
      assigns(:category).should eq category
      response.should have_http_status(:ok)
    end

    it 'should not get invalid category' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new category successfully' do
      get :new, format: 'json'
      assigns(:category).id.should eq nil
      assigns(:category).name.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct category successfully' do
      category = FactoryGirl.create(:category)
      get :edit, id: category.id,format: 'json'
      assigns(:category).should eq category
      response.should have_http_status(:ok)
    end

    it 'should not get category with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create category successfully' do
      category = FactoryGirl.create(:category)
      post :create, category: { name: category.name },format: 'json'
      assigns(:category).name.should eq category.name
      response.should have_http_status(:created)
    end

    it 'should not create category with invalid inputs' do
      post :create, category: { name: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update category successfully' do
      category1 = FactoryGirl.create(:category)
      category2 = FactoryGirl.create(:category)
      put :update,id: category1.id, category: { name: category2.name },format: 'json'
      assigns(:category).id.should eq category1.id
      assigns(:category).name.should eq category2.name
      response.should have_http_status(:ok)
    end

    it 'should not update category with invalid inputs' do
      category = FactoryGirl.create(:category)
      put :update,id: category.id, category: { name: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

   it 'should not update category with invalid category_id' do
      category = FactoryGirl.create(:category)
      put :update,id: '12345678', category: { name: category.name },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy category successfully' do
      category = FactoryGirl.create(:category)
      delete :destroy, id: category.id,format: 'json'
      assigns(:category).should eq category
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid category' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
