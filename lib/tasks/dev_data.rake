namespace :ecc do 
  namespace :dev do
    desc "add a handful of fixtures for testing"
    task :add_fixtures => :environment do
      
      opps = Opposition.find(:all)
      vens = Venue.find(:all)
      our_teams = OurTeam.find(:all)
      
       6.times do |i|
         
         m = Match.new(
                     :our_team_id => our_teams[rand(our_teams.count)].id,
                     :opposition_id =>  opps[rand(opps.count)].id,
                     :venue_id => vens[rand(vens.count)].id,
                     :match_date => i.weeks.from_now
                     )
        
        m.save
         
       end
    end
  end
end
  