class Match < ActiveRecord::Base
  belongs_to :venue
  belongs_to :opposition
  belongs_to :our_team

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
    case our_runs <=> opposition_runs
    when 1
      return "W"
    when -1
      return "L"
    when 0
      return "D"
    end
  end
end
