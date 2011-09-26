class RenameHomeTeamTable < ActiveRecord::Migration
  def up
    rename_table :home_teams, :our_teams
  end

  def down
    rename_table :our_teams, :home_team
  end
end
