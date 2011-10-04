class AddAwayWicketsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :away_wickets, :integer
  end
end
