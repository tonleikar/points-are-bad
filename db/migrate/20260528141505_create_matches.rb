class CreateMatches < ActiveRecord::Migration[8.1]
  def change
    create_table :matches do |t|
      t.string :home_team, null: false
      t.string :away_team, null: false
      t.time :kickoff, null: false
      t.integer :home_score
      t.integer :away_score
      t.boolean :finished, null: false, default: false

      t.timestamps
    end
  end
end
