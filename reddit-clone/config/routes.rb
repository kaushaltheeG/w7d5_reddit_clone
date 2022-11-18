Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:new, :create]
  resources :subs, only: [:new, :create, :show, :index] 

  resources :post, only: [:new, :create, :edit, :update, :show]

  resource :session, only: [:new, :create, :destroy]
end
