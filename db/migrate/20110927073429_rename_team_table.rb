class RenameTeamTable < ActiveRecord::Migration
  def up
    rename_table :teams, :oppositions
  end

  def down
    rename_table :oppositions, :teams
  end
end
