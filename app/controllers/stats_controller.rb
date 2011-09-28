class StatsController < ApplicationController 
  
  def index
    @all_results = Matches.all
  end                         
  
  def guess_result(home_runs, home_wickets, away_runs, away_wickets)
    
    
  end
end
