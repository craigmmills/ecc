class Match < ActiveRecord::Base
  belongs_to :venue
  belongs_to :team, :foreign_key => "away_team_id"
end
