class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  def index
    @recipe_categories = RecipeCategory.where(user_id: current_user.id)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
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
    if @recipe.update(recipe_params)
      redirect_to recipes_path
    else
      render :edit
    end
  end

  def show; end

  def destroy; end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :recipe_category_id, ingredients_attributes: %i[_destroy name brand measurement measurement_value price])
  end
end
