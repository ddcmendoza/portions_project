class RecipeForm
  include ActiveModel::Model
  attr_accessor :recipe, :name, :description, :recipe_category_id, :ingredients

  validates :name, presence: true
  def save_recipe
    @recipe = Recipe.create(name: @name, description: @description, recipe_category_id: @recipe_category_id)
    @recipe.persisted?
  end

  private

  def create_recipe; end
end
