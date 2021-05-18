class AddDetailstoIngredients < ActiveRecord::Migration[6.1]
  def change
    change_table "ingredients" do |t|
      t.string "specification", null: true
    end
    add_reference :recipe_categories, :user, foreign_key: true
    add_reference :recipes, :recipe_category, foreign_key: true
    
  end
end
