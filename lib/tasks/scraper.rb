# will use this to scrape play-cricket website for all
# fixtures, results, player stats, opponent stats

# doc = Nokogiri::HTML(open("http://elsworth.play-cricket.com/scoreboard/results.asp?
# page=2&startDay=&quickSearch=&startYear=&team=&seasonID=&fromForm=1&endMonth=&startMonth=&endYear=&endDay=&type="))
# t = doc.xpath('//table[@class = "data"]/tr')
# t.each do |tr|
#tr[5]
#end


# 

require 'open-uri'
require 'nokogiri'          
require 'date'

15.times do |i|
  html = "http://elsworth.play-cricket.com/scoreboard/results.asp?page=#{i.to_s}&startDay=&quickSearch=&startYear=&team=&seasonID=&fromForm=1&endMonth=&startMonth=&endYear=&endDay=&type="
  # puts html
  doc = Nokogiri::HTML(open(html))
  t = doc.xpath('//table[@class = "data"]/tr')
  t.shift
  t.each do |y|
    data = y.children
    match_date = Date.parse(data[0].text)
    home = true if data[1].text.match(/href/) 
    puts "Home -> #{home} : #{data[1]} : #{data[3].text} : #{data[5].text}"
    
    # puts data[5].text unless data[5].text.strip! == "Cancelled"

    #TODO Match.new(:home_team_id => "", :away_team_id => , :match_date => )
  end
end




