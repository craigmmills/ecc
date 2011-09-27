class Match < ActiveRecord::Base
  belongs_to :venue
  belongs_to :opposition, :foreign_key => "away_team_id"
  belongs_to :our_team, :foreign_key => "home_team_id"
end
