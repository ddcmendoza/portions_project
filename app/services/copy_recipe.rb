class CopyRecipe < ApplicationService
  def initialize(recipe, user)
    @user = user
    @recipe = recipe
    @ingredients = recipe.ingredients
  end

  def call
    ActiveRecord::Base.transaction do
      new_recipe = @recipe.dup
      new_recipe.parent = @recipe
      new_recipe.name += "_forked_#{DateTime.now.to_s(:number)}" if @user.id == @recipe.recipe_category.user_id
      new_recipe.recipe_category = @user.recipe_categories[0]
      @ingredients.each do |ingredient|
        new_recipe.ingredients << ingredient
      end

      if new_recipe.save
        @ingredients.each do |ingredient|
          ing_attr_parent = IngredientsRecipe.find_entry(@recipe, ingredient)
          ing_attr_child = IngredientsRecipe.find_entry(new_recipe, ingredient)
          ing_attr_child.price = ing_attr_parent.price
          ing_attr_child.measurement_value = ing_attr_parent.measurement_value
          ing_attr_child.measurement = ing_attr_parent.measurement
          ing_attr_child.save
        end
      end
    end
  end
end
