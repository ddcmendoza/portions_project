class AddIndeces < ActiveRecord::Migration[6.1]
  def change
    add_index :ingredients, [:name , :brand], unique: true
    add_index :recipe_categories, [:name, :user_id], unique: true
    #Ex:- add_index("admin_users", "username")
  end
end
