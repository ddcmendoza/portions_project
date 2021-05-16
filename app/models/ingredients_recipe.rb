class IngredientsRecipe < ApplicationRecord
  # Join table for ingredients recipes
  validates :recipe_id, presence: true
  validates :ingredient_id, presence: true
end
