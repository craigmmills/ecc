class RenameHomeScore < ActiveRecord::Migration
  def up
    rename_table :home_score, :home_runs
  end

  def down
    rename_table :home_runs, :home_score
  end
end
