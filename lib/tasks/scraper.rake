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
      2.times do |i|
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
            
            match["venue"] = data[1].text.split("-")[0].strip
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
                   
            #add the scores to match hash = TODO hard to know which team is which score - possibly use the order of the headers from the page
            
            if scores.length == 4
              match["#{first}runs"] = scores[1].text
              match["#{second}runs"] = scores[3].text
            elsif scores.length == 2
              match["#{first}runs"] = scores[0].text
              match["#{second}runs"] = scores[1].text
            end    
            # puts match       
          end
          #going to have to deal with edgecases where scores are missing
          
          matches << match
          print "."
          #TODO Match.new(:home_team_id => "", :away_team_id => , :match_date => )
        end
        
        
        
      end
      
      fill_all_refs matches
      #puts matches
    end    
end

def fill_all_refs data
  puts "fill"
  
  Venue.destroy_all
  data.each do |match|
    unless Venue.find(:first, :conditions => [ "name = ?", match["venue"]])
      v = Venue.new(:name => match["venue"]) 
      v.save
      puts v
    end
  end
  
  Opposition.destroy_all
  data.each do |match|
    unless Opposition.find(:first, :conditions => [ "name = ?", match["opposition"]])
      v = Opposition.new(:name => match["opposition"]) 
      v.save
      puts v
    end
  end
  
  
  
  
end




