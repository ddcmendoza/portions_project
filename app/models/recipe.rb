class Recipe < ApplicationRecord
    belongs_to :recipe_category
    belongs_to :parent, :class_name => "Recipe", :foreign_key => "parent_recipe_id", optional: :true
    has_many :children, :class_name => "Recipe", :foreign_key => "child_recipe_id"
    has_and_belongs_to_many :ingredients, join_table: "ingredients_recipes"
end
