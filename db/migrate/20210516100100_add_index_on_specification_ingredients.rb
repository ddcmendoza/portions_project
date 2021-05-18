class AddIndexOnSpecificationIngredients < ActiveRecord::Migration[6.1]
  def change
    add_index :ingredients, :specification, unique: true
  end
end
