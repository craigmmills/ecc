class Match < ActiveRecord::Base
  belongs_to :venue
  belongs_to :opposition, :foreign_key => "away_team_id"
  belongs_to :our_team, :foreign_key => "home_team_id"

  # TODO: no idea if this should go here, but it should work
  # Checks input for "last sunday" and finds most recent Sunday in the past
  def human_date
    
  end
end
