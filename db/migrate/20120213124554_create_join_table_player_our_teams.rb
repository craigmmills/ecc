class CreateJoinTablePlayerOurTeams < ActiveRecord::Migration
  def up
    create_table :our_teams_players do |t|
      t.integer :player_id 
      t.integer :our_team_id 
    end
  end

  def down
    drop_table :our_teams_players
  end
end
