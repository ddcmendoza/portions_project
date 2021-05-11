class CreateIngredientsRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients_recipes do |t|
      t.bigint :ingredient_id
      t.bigint :recipe_id

      t.timestamps
    end

    add_index :ingredients_recipes, [:ingredient_id,:recipe_id], unique: true
  end
end
