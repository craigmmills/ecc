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

i = 0
until i == 15
  html = "http://elsworth.play-cricket.com/scoreboard/results.asp?page=#{i.to_s}&startDay=&quickSearch=&startYear=&team=&seasonID=&fromForm=1&endMonth=&startMonth=&endYear=&endDay=&type="
  puts html
  doc = Nokogiri::HTML(open(html))
  t = doc.xpath('//table[@class = "data"]/tr')
  t.each do |y|
    d = y.children[0].text      #Sat 4th Aug 2007
    print d.to_s
    puts y.children[5].text unless y.children[5].text.strip! == "Cancelled"
  end
  i += 1
end




