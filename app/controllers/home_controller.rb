class HomeController < ApplicationController
  def index
    redirect_to new_user_session_path unless user_signed_in?
    @public_recipes = Recipe.public_recipes
  end
end
