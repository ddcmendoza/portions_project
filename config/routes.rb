Rails.application.routes.draw do
  devise_for :users , controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes
  resources :ingredients
  delete '/recipes/:id/ingredient/:ing_id', to: "recipes#recipe_remove_ingredient", as: 'recipe_remove_ingredient'
  root "home#index"
end
