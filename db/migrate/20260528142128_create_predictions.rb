class CreatePredictions < ActiveRecord::Migration[8.1]
  def change
    create_table :predictions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.integer :home_prediction, null: :false
      t.integer :away_prediction, null: :false
      t.integer :points_earned

      t.timestamps
    end

    add_index :predictions, [ :user_id, :match_id ], unique: true
  end
end
