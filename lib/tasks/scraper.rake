# will use this to scrape play-cricket website for all
# fixtures, results, player stats, opponent stats

#1.  get all the matches, results with runs and wickets for all opposition
#2.  get recent results from opposition 
#3.  get top scores of recent players of elsworth

require 'open-uri'
require 'nokogiri'          
require 'date'
require 'csv'



namespace :ecc do 
    # require 'ruby-debug19' 
    desc "get all results from play-cricket"
    task :get_results => :environment do
       
      base_url = "http://elsworth.play-cricket.com/scoreboard/"
      matches = Array.new
      
      21.times do |i|
        
        puts i
        html = "#{base_url}results.asp?page=#{(i+1).to_s}&startDay=&quickSearch=&startYear=&team=&seasonID=&fromForm=1&endMonth=&startMonth=&endYear=&endDay=&type="
        puts html
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
          
                    
                    
          
          #TODO add the play url to the match model
          
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
            
            #get the wickets from the scorecard page
            wickets = score_doc.xpath('//*[(@id = "scorecard")]//td')     
            wicket_type = first
            wickets.each do |td|
              if td.text.match("wickets")
                match["#{wicket_type}wickets"] = td.text.scan(/\d+/)[0]
                wicket_type = second
              end
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
      create_our_teams
      
      #fill matches table
      Match.destroy_all
      puts matches.to_yaml
      puts matches.length
     
      debugger  
        matches.each do |match|
          m = Match.new(
                    :our_team_id => OurTeam.find(:first, :conditions => ["name = ?", match["our_team"]]).id,
                    :opposition_id => Opposition.find(:first, :conditions => ["name = ?", match["opposition"]]).id,
                    :our_runs => match["our_team_runs"],
                    :opposition_runs => match["opposition_runs"],
                    :opposition_wickets => match["opposition_wickets"],
                    :our_wickets => match["our_team_wickets"],
                    :venue_id => Venue.find(:first, :conditions => ["name = ?", match["venue"]]).id,
                    :match_date => match["match_date"],
                    :result => match["result"]
                    )
          m.save 
         
        end
        
    end #task
end #namespace


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

def create_our_teams
  OurTeam.create(:name=>"1st XI")
  OurTeam.create(:name=>"2nd XI")
  puts "=============="
  puts "Added OurTeams"
  puts "=============="
end




