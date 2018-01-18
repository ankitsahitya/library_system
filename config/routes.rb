Rails.application.routes.draw do
	resources :libraries
	resources :categories
	resources :books
	resources :members
	resources :issue_histories
end
