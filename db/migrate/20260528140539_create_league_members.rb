class CreateLeagueMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :league_members do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :league, null: false, foreign_key: { to_table: :leagues }

      t.timestamps
    end
  end
end
