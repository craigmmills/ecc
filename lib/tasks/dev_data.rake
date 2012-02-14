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
    
    
    desc "add players to model"
    task :add_players => :environment do
    
    
    Player.destroy_all
    
      CSV.foreach("/Users/giarcsllim/Documents/code/rails/ecc/lib/data/players.csv", :headers => :first_row) do |row|
          
          p = Player.new(
              :first_name => row["first_name"],
              :last_name => row["last_name"],
              :email => row["email"],
              :description => row["description"],
              :mob_num => row["mob_num"],
              :home_num => row["home_num"],
              :url => row["url"]          
          )
          
          p.save
          
          
      end
      
      
    end
    
    
  end
end
  