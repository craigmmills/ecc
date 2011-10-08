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
      
      15.times do |i|
        html = "#{base_url}results.asp?page=#{i.to_s}&startDay=&quickSearch=&startYear=&team=&seasonID=&fromForm=1&endMonth=&startMonth=&endYear=&endDay=&type="
        
        doc = Nokogiri::HTML(open(html))
        t = doc.xpath('//table[@class = "data"]/tr')
        
        
        t.shift
        t.each do |y|
          match = {}
          data = y.children
          
          match["match_date"] = Date.parse(data[0].text)
          
          home = false
          #get the home or away status of elsworth
          home = true if data[1].text.strip.upcase == "1ST XI" || data[1].text.strip.upcase == "2ND XI"
          puts home
          unless data[5].text.to_s.strip.upcase.match("ABANDONED") || data[5].text.to_s.strip.upcase.match("CANCELLED")
            #gets url of the detailed scorecard
            puts data[5].text.to_s.strip.upcase
            scorecard_url = "#{base_url}#{data[6].children.first['href']}"   
            puts scorecard_url
            score_doc = Nokogiri::HTML(open(scorecard_url))
            
            #need to get two types of scorecard- one where the data are full the other where it is patchy
            scores = score_doc.xpath('//tr[(((count(preceding-sibling::*) + 1) = 14) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 3) and parent::*)]//strong')
            
            #try with different xpath if no results are returned     
            scores = score_doc.xpath('//td[(((count(preceding-sibling::*) + 1) = 3) and parent::*)]//strong') if scores.empty?
            
            
        
            #add the scores to match hash = TODO hard to know which team is which score - possibly use the order of the headers from the page
            
            if scores.length == 4
              
            elsif scores.length == 2
              
            elsif scores.length == 1
            
              
            end
            
             
            puts scores
          end
          #going to have to deal with edgecases where scores are missing
          

          #TODO Match.new(:home_team_id => "", :away_team_id => , :match_date => )
        end
      end
      
    end    
end


