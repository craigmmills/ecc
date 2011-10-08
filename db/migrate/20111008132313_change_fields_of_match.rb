class ChangeFieldsOfMatch < ActiveRecord::Migration
  def up
    rename_column :matches, :home_team_id, :our_team_id
    rename_column :matches, :away_team_id, :opposition_id 
    rename_column :matches, :home_runs, :our_runs
    rename_column :matches, :home_wickets, :our_wickets  
  end

  def down
    rename_column :matches, :our_team_id, :home_team_id
    rename_column :matches, :opposition_id, :away_team_id
    rename_column :matches, :our_runs, :home_runs
    rename_column :matches, :our_wickets, :home_wickets
  end
end
