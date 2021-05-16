Rails.application.routes.draw do
  get 'ingredients/index'
  get 'ingredients/show'
  get 'ingredients/edit'
  patch 'ingredients/update'
  get 'ingredients/new'
  post 'ingredients/create'
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes
  root "home#index"
end
