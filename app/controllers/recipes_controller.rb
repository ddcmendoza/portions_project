class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit destroy recipe_remove_ingredient new_dish]
  def index
    @recipe_categories = RecipeCategory.where(user_id: current_user.id)
  end

  def create
    @recipe = CreateRecipe.new(recipe_params)
    if @recipe.save
      @recipe_only = CheckPrices.new(Recipe.find_by(@recipe.recipe))
      redirect_to recipes_path
    else
      render :new
    end
  end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def update
    @recipe = UpdateRecipe.new(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipes_path
    else
      redirect_to recipe_path(params[:id])
    end
  end

  def show; end

  def destroy; end

  def recipe_remove_ingredient
    @recipe.ingredients.delete(Ingredient.find(params[:ing_id]))
    redirect_to recipe_path(params[:id])
  end

  def new_dish
    
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id]) if params[:action] != 'destroy'
  end

  def recipe_params
    params.require(:recipe).permit(:name, :id, :description, :recipe_category_id, ingredients_attributes: [:_destroy, :name, :brand, :id, { ingredients_recipes_attributes: %i[measurement measurement_value price] }])
  end
end
