class IngredientRecipeJoinTableEdit < ActiveRecord::Migration[6.1]
  def change
    remove_column :ingredients, :measurement
    remove_column :ingredients, :measurement_value
    remove_column :ingredients, :price
    remove_column :ingredients, :specification

    add_column :ingredients_recipes, :measurement, :string
    add_column :ingredients_recipes, :measurement_value, :decimal
    add_column :ingredients_recipes, :price, :decimal
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
