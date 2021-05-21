class AddApiTokenandUuiDtoUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :api_key
      t.string :uuid
    end
    add_index :users, :api_key,                unique: true
    add_index :users, :uuid, unique: true
  end
end
