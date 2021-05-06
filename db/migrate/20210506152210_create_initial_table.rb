class CreateInitialTable < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.timestamps
    end

    create_table :recipes do |t|
      t.timestamps
    end

    create_table :ingredients do |t|
      t.timestamps
    end
  end

  def down
    drop_table :users
    drop_table :recipes
    drop_table :ingredients
  end
end
