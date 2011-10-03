class RenameOppositionFields < ActiveRecord::Migration
  def up
    rename_column :matches, :away_runs, :opposition_runs
    rename_column :matches, :away_wickets, :opposition_wickets
  end

  def down
    rename_column :matches, :opposition_runs, :away_runs
    rename_column :matches, :opposition_wickets, :away_wickets
  end
end
