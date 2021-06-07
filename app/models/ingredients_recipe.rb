class IngredientsRecipe < ApplicationRecord
  # Join table for ingredients recipes
  validates :recipe_id, presence: true
  validates :ingredient_id, presence: true

  belongs_to :recipe
  belongs_to :ingredient

  validates :measurement, presence: true
  validates :measurement_value, presence: true
  validates :measurement_value, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }, allow_nil: true

  def self.find_entry(recipe, ingredient)
    where(ingredient_id: ingredient.id).find_by(recipe_id: recipe.id)
  end
end
