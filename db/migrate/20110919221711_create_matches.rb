class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.string :home_score
      t.string :away_score
      t.integer :venue_id

      t.timestamps
    end
  end
end
