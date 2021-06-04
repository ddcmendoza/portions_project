class UpdateRecipe
  def initialize(id)
    @recipe = Recipe.find(id)
    @ingredients = @recipe.ingredients
  end

  def update(params)
    recipe_attr = params.except(:ingredients_attributes)
    ingredients_attr = params[:ingredients_attributes] || []
    ActiveRecord::Base.transaction do
      @recipe.update(recipe_attr)
      ingredients_attr.each do |ingredient|
        to_destroy = ingredient[1].slice(:_destroy)[:_destroy] == '1'
        ing = ingredient[1].except(:_destroy, :ingredients_recipes_attributes, :_post)
        ing_rec_attr = ingredient[1].slice(:ingredients_recipes_attributes)[:ingredients_recipes_attributes]
        if ingredient[1][:_post] == '1' && ing_rec_attr[:price] != ''
          params_for_service = ing.merge(ing_rec_attr)
          PostPrice.call(params_for_service)
        end
        i_tmp = Ingredient.find_by(ing) || Ingredient.create(ing.except(:id))
        i = i_tmp
        if to_destroy
          @recipe.ingredients.delete(i)
        else
          @recipe.ingredients << i unless IngredientsRecipe.exists?(recipe_id: @recipe.id, ingredient_id: i.id)
          i_r = IngredientsRecipe.find_entry(@recipe, i)
          i_r.update(ing_rec_attr)
        end
      end
      return true
    end
    false
  end
end
