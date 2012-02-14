class MatchesController < ApplicationController
  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.our_results(:order => 'match_date DESC', :limit  => 30)
    
    
    #todo- much nicer way to do this I'm sure
    month_names = ["", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    #construct the structure of the fixtures for display
    
    fixtures = Match.all(:order => "match_date")
    @fix_table = {}
    
    fixtures.each do |fix|
    
      month = month_names[fix.match_date.month]
    
      @fix_table[month] = [] unless @fix_table.has_key?(month)
      
      if fix.venue.name == "Elsworth"
        venue = "Home"
      else
        venue = "Away"
      end
      
      delim = "/"
      
      delim = "" if fix.our_runs.nil?
      
      #find out the month
      @fix_table[month] << {
        "team" => fix.our_team.name,
        "opposition" => fix.opposition.name,
        "our_score" => "#{fix.our_runs} #{delim} #{fix.our_wickets}",
        "opp_score" => "#{fix.opposition_runs} #{delim} #{fix.opposition_wickets}",
        "match_date" => fix.match_date,
        "result" => fix.result,
        "venue" => venue
      }
      
  end
    
    
    
    
    @results = Match.summary_results
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matches }
    end
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
    @match = Match.find(params[:id])
    
    #choose view based on fixture or result
    if @match.fixture?
      render 'fixture' 
    else  
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @match }
    end
  end
  
  end
  
  def new
    @match = Match.new
    @match.match_date = Match.last.match_date + 7
    @match.our_team_id = 1
    @match.opposition_id = 2
  end
  
  def create
    @match = Match.new(params[:match])
    @match.result =  @match.guess_result if @match.result.blank?
    
    respond_to do |format|
      if @match.save
        format.html { redirect_to(matches_path, :notice => 'Match was successfully created.') }
        format.xml  { render :xml => @match, :status => :created, :location => @match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @match = Match.find(params[:id])
  end     
  
  def update
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to matches_path, notice: 'Match was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to matches_url }
      format.json { head :ok }
    end
  end


  
end
