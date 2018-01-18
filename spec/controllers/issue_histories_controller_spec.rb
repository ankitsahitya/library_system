require 'rails_helper'

RSpec.describe IssueHistoriesController, type: :controller do
	context 'GET#index' do
    it 'should show all issue_histories successfully' do
    	issueHistory1 = FactoryGirl.create(:issue_history)
    	issueHistory2 = FactoryGirl.create(:issue_history)
      get :index, format: 'json'
      assigns(:issueHistories).should include issueHistory1
      assigns(:issueHistories).should include issueHistory2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get issueHistory successfully' do
      issueHistory = FactoryGirl.create(:issue_history)
      get :show, id: issueHistory.id, format: 'json'
      assigns(:issueHistory).should eq issueHistory
      response.should have_http_status(:ok)
    end

    it 'should not get invalid issueHistory' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new issueHistory successfully' do
      get :new, format: 'json'
      assigns(:issueHistory).id.should eq nil
      assigns(:issueHistory).member_id.should eq nil
      assigns(:issueHistory).book_id.should eq nil
      assigns(:issueHistory).issue_date.should eq nil
      assigns(:issueHistory).return_date.should eq nil
      assigns(:issueHistory).type_of_book.should eq nil
      assigns(:issueHistory).no_of_copies.should eq 1
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct issueHistory successfully' do
      issueHistory = FactoryGirl.create(:issue_history)
      get :edit, id: issueHistory.id,format: 'json'
      assigns(:issueHistory).should eq issueHistory
      response.should have_http_status(:ok)
    end

    it 'should not get issueHistory with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create issueHistory successfully' do
      issueHistory = FactoryGirl.create(:issue_history)
      post :create, issue_history: { member_id: issueHistory.member_id, book_id: issueHistory.book_id, issue_date: issueHistory.issue_date, return_date: issueHistory.return_date, type_of_book: issueHistory.type_of_book, no_of_copies: issueHistory.no_of_copies },format: 'json'
      assigns(:issueHistory).member_id.should eq issueHistory.member_id
      assigns(:issueHistory).book_id.should eq issueHistory.book_id
      assigns(:issueHistory).issue_date.should eq issueHistory.issue_date
      assigns(:issueHistory).return_date.should eq issueHistory.return_date
      assigns(:issueHistory).type_of_book.should eq issueHistory.type_of_book
      assigns(:issueHistory).no_of_copies.should eq issueHistory.no_of_copies
      response.should have_http_status(:created)
    end

    it 'should not create issueHistory with invalid inputs' do
      post :create, issue_history: { member_id: nil, book_id: nil, issue_date: nil, return_date: nil, type_of_book: nil, no_of_copies: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create issueHistory with invalid member_id' do
      issueHistory = FactoryGirl.create(:issue_history)
      post :create, issue_history: { member_id: '123456789', book_id: issueHistory.book_id, issue_date: issueHistory.issue_date, return_date: issueHistory.return_date, type_of_book: issueHistory.type_of_book, no_of_copies: issueHistory.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create issueHistory with invalid book_id' do
      issueHistory = FactoryGirl.create(:issue_history)
      post :create, issue_history: { member_id: issueHistory.book_id, book_id: '123456', issue_date: issueHistory.issue_date, return_date: issueHistory.return_date, type_of_book: issueHistory.type_of_book, no_of_copies: issueHistory.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update issueHistory successfully' do
      issueHistory1 = FactoryGirl.create(:issue_history)
      issueHistory2 = FactoryGirl.create(:issue_history)
      put :update,id: issueHistory1.id, issue_history: { member_id: issueHistory2.member_id, book_id: issueHistory2.book_id, issue_date: issueHistory2.issue_date, return_date: issueHistory2.return_date, type_of_book: issueHistory2.type_of_book, no_of_copies: issueHistory2.no_of_copies },format: 'json'
      assigns(:issueHistory).id.should eq issueHistory1.id
      assigns(:issueHistory).member_id.should eq issueHistory2.member_id
      assigns(:issueHistory).book_id.should eq issueHistory2.book_id
      assigns(:issueHistory).issue_date.should eq issueHistory2.issue_date
      assigns(:issueHistory).return_date.should eq issueHistory2.return_date
      assigns(:issueHistory).type_of_book.should eq issueHistory2.type_of_book
      assigns(:issueHistory).no_of_copies.should eq issueHistory2.no_of_copies
      response.should have_http_status(:ok)
    end

    it 'should not update issueHistory with invalid inputs' do
      issueHistory = FactoryGirl.create(:issue_history)
      put :update,id: issueHistory.id, issue_history: { member_id: nil, book_id: nil, issue_date: nil, return_date: nil, type_of_book: nil, no_of_copies: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

   it 'should not update issueHistory with invalid issueHistory_id' do
      issueHistory = FactoryGirl.create(:issue_history)
      put :update,id: '12345678', issue_history: { member_id: issueHistory.member_id, book_id: issueHistory.book_id, issue_date: issueHistory.issue_date, return_date: issueHistory.return_date, type_of_book: issueHistory.type_of_book, no_of_copies: issueHistory.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update issueHistory with invalid member_id' do
      issueHistory = FactoryGirl.create(:issue_history)
      post :update,id: issueHistory.id, issue_history: { member_id: '123456789', book_id: issueHistory.book_id, issue_date: issueHistory.issue_date, return_date: issueHistory.return_date, type_of_book: issueHistory.type_of_book, no_of_copies: issueHistory.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update issueHistory with invalid book_id' do
      issueHistory = FactoryGirl.create(:issue_history)
      post :update,id: issueHistory.id, issue_history: { member_id: issueHistory.book_id, book_id: '123456', issue_date: issueHistory.issue_date, return_date: issueHistory.return_date, type_of_book: issueHistory.type_of_book, no_of_copies: issueHistory.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy issueHistory successfully' do
      issueHistory = FactoryGirl.create(:issue_history)
      delete :destroy, id: issueHistory.id,format: 'json'
      assigns(:issueHistory).should eq issueHistory
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid issueHistory' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
