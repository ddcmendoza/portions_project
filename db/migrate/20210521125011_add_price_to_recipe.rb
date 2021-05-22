class AddPriceToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :price, :decimal, default: 0.00
    add_column :recipes, :public, :boolean, default: false
    add_column :recipes, :servings, :integer, default: 1
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
