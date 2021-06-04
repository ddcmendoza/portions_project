Rails.application.routes.draw do
  devise_for :users , controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  resources :recipes
  get '/recipes/make/:id', to: "recipes#new_dish", as: "new_dish"
  get '/recipes/view/:id', to: "recipes#view_recipe", as: "view_recipe"
  delete '/recipes/:id/ingredient/:ing_id', to: "recipes#recipe_remove_ingredient", as: 'recipe_remove_ingredient'
  post '/recipes/fork/:id', to: "recipes#fork_recipe", as: "fork_recipe"
  post '/recipes/share/:id', to: "recipes#share_recipe", as: "share_recipe"  
  get '/ingredients/fetch_price', to: "ingredients#fetch_price", as: "fetch_price"
  resources :ingredients
end
