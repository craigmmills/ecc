class Match < ActiveRecord::Base
  belongs_to :venue
  belongs_to :opposition, :foreign_key => "away_team_id"
  belongs_to :our_team, :foreign_key => "home_team_id"

  # TODO: no idea if this should go here, but it should work
  # Checks input for "last sunday" and finds most recent Sunday in the past
  def human_date
    # Accept either a date in "DD/MM/YY" or "DD/MM" or "last sunday" "last sun" or "last saturday" "last sat"
    # Abandoned this when realised how well date.parse works
  end
  
  def self.summary_results
    won = Match.where(:result => "W").count
    drawn = Match.where(:result => "D").count
    lost = Match.where(:result => "L").count
    return [won, drawn, lost]
  end

  def guess_result
    # puts home_runs
    # puts away_runs
    case home_runs <=> away_runs
    when 1
      return "W"
    when -1
      return "L"
    when 0
      return "D"
    end
  end
end
