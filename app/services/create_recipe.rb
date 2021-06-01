class CreateRecipe
  attr_accessor :recipe

  def initialize(params)
    @recipe = params.except(:ingredients_attributes)
    @ingredients = params[:ingredients_attributes] || []
  end

  def save
    ActiveRecord::Base.transaction do
      r = Recipe.create(@recipe)
      @ingredients.each do |ingredient|
        next if ingredient[1].slice(:_destroy)[:_destroy] == '1'

        ing = ingredient[1].except(:_destroy, :ingredients_recipes_attributes, :_post)
        ing_rec_attr = ingredient[1].slice(:ingredients_recipes_attributes)[:ingredients_recipes_attributes]
        if ingredient[1][:_post] == '1' && ing_rec_attr[:price] != ''
          params_for_service = ing.merge(ing_rec_attr)
          PostPrice.call(params_for_service)
        end
        i = Ingredient.find_by(ing) || Ingredient.create(ing)
        r.ingredients << i
        i_r = IngredientsRecipe.find_entry(r, i)
        i_r.update(ing_rec_attr)
      end
      return true
    end
    false
  end
end
