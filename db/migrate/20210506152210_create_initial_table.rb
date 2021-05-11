class CreateInitialTable < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.timestamps
    end

    create_table :recipes do |t|
      t.string :name
      t.string :description
      
      t.timestamps
    end

    create_table :ingredients do |t|
      t.string :name
      t.string :brand
      t.string :measurement
      t.decimal :measurement_value
      t.decimal :price

      t.timestamps
    end
  end

  def down
    drop_table :users
    drop_table :recipes
    drop_table :ingredients
  end
end
