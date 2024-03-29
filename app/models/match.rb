class Match < ActiveRecord::Base
  belongs_to :venue
  belongs_to :opposition
  belongs_to :our_team
  
  
  scope :fixtures, where("matches.match_date > '#{Time.now}'").order("matches.match_date")
  scope :short_fixtures, limit(9).fixtures
  scope :our_results, where("matches.match_date < '#{Time.now}'")
  scope :latest_results, limit(10).our_results.order("matches.match_date DESC")
  
  
  #check if match has no results (then it's a fixture)
  def fixture?
    self.result == nil
  end
  
  
  def self.summary_results
    won = Match.where(:result => "Won").count
    drawn = Match.where(:result => "Draw").count
    lost = Match.where(:result => "Lost").count
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
