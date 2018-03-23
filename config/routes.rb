Rails.application.routes.draw do
	resources :libraries
	resources :categories
	resources :books
	resources :members
	resources :issue_histories
  get '/auth/:provider/callback', to: 'users#create'
  get '/logout', to: 'users#logout'
end
