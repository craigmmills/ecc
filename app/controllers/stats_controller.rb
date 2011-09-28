class StatsController < ApplicationController 
  
  def index
    @all_results = Matches.all
  end                         
  
  def guess_result(home_runs, away_runs)
    # TODO: For simplicity now, all results are from the home team point of view - this won't work in multi-team environment
    # TODO: Need to check the veracity of this - it looks too simple
    case home_runs <=> away_runs
      when 1
        return "W" # W for Win!
      when 0
        return "D" # D for draw
      when -1
        return "L" # L for loss
      end
  end
    
end
