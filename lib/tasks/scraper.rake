# will use this to scrape play-cricket website for all
# fixtures, results, player stats, opponent stats

# doc = Nokogiri::HTML(open("http://elsworth.play-cricket.com/scoreboard/results.asp?
# page=2&startDay=&quickSearch=&startYear=&team=&seasonID=&fromForm=1&endMonth=&startMonth=&endYear=&endDay=&type="))
# t = doc.xpath('//table[@class = "data"]/tr')
# t.each do |tr|
#tr[5]
#end


# fields in the match table

#         home_team_id      
#         away_team_id      
#         home_runs     
#         opposition_runs     
#         venue_id      
#         created_at      
#         updated_at      
#         match_date      
#         home_wickets      
#         opposition_wickets        
#         result


#collect all away teams and insert into model


require 'open-uri'
require 'nokogiri'          
require 'date'


namespace :ecc do 
    desc "get all results from play-cricket"
    task :get_results => :environment do
      
      base_url = "http://elsworth.play-cricket.com/scoreboard/"
      matches = Array.new
      15.times do |i|
        html = "#{base_url}results.asp?page=#{i.to_s}&startDay=&quickSearch=&startYear=&team=&seasonID=&fromForm=1&endMonth=&startMonth=&endYear=&endDay=&type="
        
        doc = Nokogiri::HTML(open(html))
        t = doc.xpath('//table[@class = "data"]/tr')
        
        
        t.shift
        t.each do |y|
          match = {}
          data = y.children
          
          match["match_date"] = Date.parse(data[0].text)
          
          
          #get the home or away status of elsworth and the oppostion team
          if data[1].text.strip.upcase == "1ST XI" || data[1].text.strip.upcase == "2ND XI"
            match["opposition"] = data[3].text
            match["our_team"] = data[1].text
            match["venue"] = "Elsworth"
          else
            match["opposition"] = data[1].text
            match["our_team"] = data[3].text
            
            #remove the team type from the venue
            venue = data[1].text.to_s.split("-")[0]
            match["venue"] = venue[0..-2] #strip didn't work on this due to some weird invisible character
          end
          
          #get result from first table
          if data[5].text.upcase.match "ELSWORTH"
            match["result"] = "Won"
          elsif data[5].text.to_s.strip.upcase.match("ABANDONED") || data[5].text.to_s.strip.upcase.match("CANCELLED")
            match["result"] = "No Result"
          else
            match["result"] = "Lost"
          end
          
                    
          #get the scores from the details page
          #puts match
          unless match["result"] == "No Result"
            
            #gets url of the detailed scorecard
            scorecard_url = "#{base_url}#{data[6].children.first['href']}"   
            score_doc = Nokogiri::HTML(open(scorecard_url))
            
            #figure out who batted first so we can get the scores in the right order     
            order = score_doc.xpath('//h2//strong')
            
            if data[1].text.strip.upcase == "1ST XI" || data[1].text.strip.upcase == "2ND XI"
              first = "opposition_"
              second = "our_team_" 
            else
              first = "our_team_" 
              second = "opposition_"
            end
         
            #need to get two types of scorecard- one where the data are full the other where it is patchy
            scores = score_doc.xpath('//tr[(((count(preceding-sibling::*) + 1) = 14) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 3) and parent::*)]//strong')
            
            #try with different xpath if no results are returned     
            scores = score_doc.xpath('//td[(((count(preceding-sibling::*) + 1) = 3) and parent::*)]//strong') if scores.empty?
                   
            #add the scores to match array size- sometimes the scrape returns different number of tds depending on the page
            if scores.length == 4
              match["#{first}runs"] = scores[1].text
              match["#{second}runs"] = scores[3].text
            elsif scores.length == 2
              match["#{first}runs"] = scores[0].text
              match["#{second}runs"] = scores[1].text
            end      
          end
          
          #TODO deal with edgecases where scores are missing
          
          #add match to matches array
          matches << match
          print "."
          
        end
        
      end
      
      #fill all the refs before adding the matches
      fill_all_models matches
      
      #fill matches table
      Match.destroy_all
      matches.each do |match|
        m = Match.new(
                  :our_team_id => OurTeam.find(:first, :conditions => ["name = ?", match["our_team"]]).id,
                  :opposition_id => Opposition.find(:first, :conditions => ["name = ?", match["opposition"]]).id,
                  :our_runs => match["our_team_runs"],
                  :opposition_runs => match["opposition_runs"],
                  :venue_id => Venue.find(:first, :conditions => ["name = ?", match["venue"]]).id,
                  :match_date => match["match_date"],
                  :result => match["result"]
                  )
        m.save          
      end
      
      
      #puts matches
    end    
end

# id      
# our_team_id     
# opposition_id     
# our_runs      
# opposition_runs     
# venue_id      
# created_at      
# updated_at      
# match_date      
# our_wickets     
# opposition_wickets      
# result

def fill_all_models data
  puts "fill"
  
  Venue.destroy_all
  Opposition.destroy_all
  data.each do |match|
    unless Venue.find(:first, :conditions => [ "name = ?", match["venue"]])
      v = Venue.new(:name => match["venue"]) 
      v.save
      puts v
    end
    
    unless Opposition.find(:first, :conditions => [ "name = ?", match["opposition"]])
      o = Opposition.new(:name => match["opposition"]) 
      o.save
      puts o
    end
  end
  
  
    
  
end




