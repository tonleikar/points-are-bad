class CreateLeagues < ActiveRecord::Migration[8.1]
  def change
    create_table :leagues do |t|
      t.string :name
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :join_code

      t.timestamps
    end
    add_index :leagues, :join_code, unique: true
  end
end
