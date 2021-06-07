class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit destroy recipe_remove_ingredient new_dish fork_recipe share_recipe view_recipe]
  def index
    @recipe_categories = RecipeCategory.where(user_id: current_user.id)
  end

  def create
    @recipe = CreateRecipe.new(recipe_params) # Change to Form Object later asdlkajd;lkasdj hassle i-handle neto
    if @recipe.save
      redirect_to recipes_path, notice: 'Successfully created new Recipe'
    else
      @recipe = Recipe.new
      render :new, danger: 'Something went wrong.'
    end
  end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def update
    @recipe = UpdateRecipe.new(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipes_path, notice: 'Successfully updated Recipe!'
    else
      redirect_to recipe_path(params[:id]), danger: 'Something went wrong.'
    end
  end

  def show; end

  def destroy
    Recipe.destroy(params[:id])
    redirect_to recipes_path, notice: 'Successfully deleted Recipe!'
  end

  def recipe_remove_ingredient
    @recipe.ingredients.delete(Ingredient.find(params[:ing_id]))
    redirect_to recipe_path(params[:id]), notice: 'Ingredient removed from Recipe!'
  end

  def new_dish; end

  def fork_recipe
    @new_recipe = CopyRecipe.call(@recipe, current_user)
    redirect_to recipes_path, notice: 'Recipe forked!'
  end

  def share_recipe
    @recipe.update(public: @recipe.public ? false : true)
    redirect_to recipes_path, notice: @recipe.public ? 'Recipe Shared' : 'Recipe set to Private'
  end

  def view_recipe; end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id]) if params[:action] != 'destroy'
  end

  def recipe_params
    params.require(:recipe).permit(:name, :id, :description, :recipe_category_id, ingredients_attributes: [:_destroy, :_post, :name, :brand, :id, { ingredients_recipes_attributes: %i[measurement measurement_value price] }])
  end
end
