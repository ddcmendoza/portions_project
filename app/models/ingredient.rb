class Ingredient < ApplicationRecord
    has_and_belongs_to_many :recipes, join_table: "ingredients_recipes"
end
