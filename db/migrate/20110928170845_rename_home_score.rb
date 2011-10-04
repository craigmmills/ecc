class RenameHomeScore < ActiveRecord::Migration
  def up
    rename_column :matches, :home_score, :home_runs
  end

  def down
  end
end