class CreateRecipe
  def initialize(params)
    @recipe = params.except(:ingredients_attributes)
    @ingredients = params[:ingredients_attributes] || []
  end

  def save
    ActiveRecord::Base.transaction do
      r = Recipe.create(@recipe)
      @ingredients.each do |ingredient|
        to_destroy = ingredient[1].slice(:_destroy)[:_destroy] == '1'
        next if to_destroy

        ing = ingredient[1].except(:_destroy, :ingredients_recipes_attributes)
        ing_rec_attr = ingredient[1].slice(:ingredients_recipes_attributes)[:ingredients_recipes_attributes]
        i = Ingredient.create(ing) || Ingredient.find_by(ing)
        r.ingredients << i
        i_r = IngredientsRecipe.find_entry(r, i)
        i_r.update(ing_rec_attr)
      end
      return true
    end
    false
  end
end
