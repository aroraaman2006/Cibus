Rails.application.routes.draw do
  resources :users
  
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'user#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :restaurants do
  	resources :reviews
  end

  get 'restaurant/:id/remove_photo', to: 'restaurants#remove_photo', as: 'remove_restaurant_photo'


  root 'restaurants#index'
  
  resources :categories

end