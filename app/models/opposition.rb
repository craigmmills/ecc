class Opposition < ActiveRecord::Base
  has_many :matches
  belongs_to :venue
  
  
  def winning_scores
  
    top_scores = Array.new
    self.matches.each do |match|
      
      if match.result == "Won"
        top_scores << match.our_runs.to_i unless match.our_runs.nil?
      else       
        top_scores << match.opposition_runs.to_i unless match.opposition_runs.nil?
      end
      
    end
    
    return top_scores.sort {|a, b| b <=> a}
  end
  
  
end
