require 'rails_helper'

RSpec.describe BooksController, type: :controller do
	context 'GET#index' do
    it 'should show all books successfully' do
    	book1 = FactoryGirl.create(:book)
    	book2 = FactoryGirl.create(:book)
      get :index, format: 'json'
      assigns(:books).should include book1
      assigns(:books).should include book2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get book successfully' do
      book = FactoryGirl.create(:book)
      get :show, id: book.id, format: 'json'
      assigns(:book).should eq book
      response.should have_http_status(:ok)
    end

    it 'should not get invalid book' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new book successfully' do
      get :new, format: 'json'
      assigns(:book).id.should eq nil
      assigns(:book).library_id.should eq nil
      assigns(:book).category_id.should eq nil
      assigns(:book).name.should eq nil
      assigns(:book).price.should eq nil
      assigns(:book).author.should eq nil
      assigns(:book).publication.should eq nil
      assigns(:book).code.should eq nil
      assigns(:book).version.should eq nil
      assigns(:book).no_of_copies.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct book successfully' do
      book = FactoryGirl.create(:book)
      get :edit, id: book.id,format: 'json'
      assigns(:book).should eq book
      response.should have_http_status(:ok)
    end

    it 'should not get book with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create book successfully' do
      book = FactoryGirl.create(:book)
      post :create, book: { name: book.name, author: book.author, price: book.price, library_id: book.library_id, category_id: book.category_id, publication: book.publication, code: book.code, version: book.version, no_of_copies: book.no_of_copies },format: 'json'
      assigns(:book).library_id.should eq book.library_id
      assigns(:book).category_id.should eq book.category_id
      assigns(:book).name.should eq book.name
      assigns(:book).price.should eq book.price
      assigns(:book).author.should eq book.author
      assigns(:book).publication.should eq book.publication
      assigns(:book).code.should eq book.code
      assigns(:book).version.should eq book.version
      assigns(:book).no_of_copies.should eq book.no_of_copies
      response.should have_http_status(:created)
    end

    it 'should not create book with invalid inputs' do
      post :create, book: { name: nil, author: nil, price: nil, library_id: nil, category_id: nil, publication: nil, code: nil, version: nil, no_of_copies: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create book with invalid library_id' do
      book = FactoryGirl.create(:book)
      post :create, book: { name: book.name, author: book.author, price: book.price, library_id: '1234567', category_id: book.category_id, publication: book.publication, code: book.code, version: book.version, no_of_copies: book.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create book with invalid category_id' do
      book = FactoryGirl.create(:book)
      post :create, book: { name: book.name, author: book.author, price: book.price, library_id: book.library_id, category_id: '12345678', publication: book.publication, code: book.code, version: book.version, no_of_copies: book.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update book successfully' do
      book1 = FactoryGirl.create(:book)
      book2 = FactoryGirl.create(:book)
      put :update,id: book1.id, book: { name: book2.name, author: book2.author, price: book2.price, library_id: book2.library_id, category_id: book2.category_id, publication: book2.publication, code: book2.code, version: book2.version, no_of_copies: book2.no_of_copies },format: 'json'
      assigns(:book).id.should eq book1.id
      assigns(:book).library_id.should eq book2.library_id
      assigns(:book).category_id.should eq book2.category_id
      assigns(:book).name.should eq book2.name
      assigns(:book).price.should eq book2.price
      assigns(:book).author.should eq book2.author
      assigns(:book).publication.should eq book2.publication
      assigns(:book).code.should eq book2.code
      assigns(:book).version.should eq book2.version
      assigns(:book).no_of_copies.should eq book2.no_of_copies
      response.should have_http_status(:ok)
    end

    it 'should not update book with invalid inputs' do
      book = FactoryGirl.create(:book)
      put :update,id: book.id, book: { name: nil, author: nil, price: nil, library_id: nil, category_id: nil, publication: nil, code: nil, version: nil, no_of_copies: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update book with invalid book_id' do
      book = FactoryGirl.create(:book)
      put :update,id: '12345678', book: { name: book.name, author: book.author, price: book.price, library_id: book.library_id, category_id: book.category_id, publication: book.publication, code: book.code, version: book.version, no_of_copies: book.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update book with invalid library_id' do
      book1 = FactoryGirl.create(:book)
      book2 = FactoryGirl.create(:book)
      put :update,id: book1.id, book: { name: book2.name, author: book2.author, price: book2.price, library_id: '1234567', category_id: book2.category_id, publication: book2.publication, code: book2.code, version: book2.version, no_of_copies: book2.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update book with invalid category_id' do
      book1 = FactoryGirl.create(:book)
      book2 = FactoryGirl.create(:book)
      put :update,id: book1.id, book: { name: book2.name, author: book2.author, price: book2.price, library_id: book.library_id, category_id: '12345678', publication: book2.publication, code: book2.code, version: book2.version, no_of_copies: book2.no_of_copies },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy book successfully' do
      book = FactoryGirl.create(:book)
      delete :destroy, id: book.id,format: 'json'
      assigns(:book).should eq book
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid book' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
