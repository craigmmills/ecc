class RenameAwayScoreToAwayRuns < ActiveRecord::Migration
  def up
    rename_column :matches, :away_score, :away_runs
  end

  def down
  end
end