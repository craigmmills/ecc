class NewsController < ApplicationController
  
  def val_new_news
   
   #check the email, if fine save news
   logger.debug "here are the params: #{params}"
   
   
   if Player.find(:first, :conditions => [ "email = ?", params[:email]])
     latest_news = News.new({ :title => params[:title], :description => params[:description]}, :without_protection => true)
     latest_news.save
    else
      logger.debug "nothing"
   end
   
   
   respond_to do |format|
       format.html { redirect_to '/news/' }
   end  
  end
  
  # GET /news
  # GET /news.json
  def index
    @news = News.all
    @latest_news = News.latest_news

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end
  
  # GET /news/new
  # GET /news/new.json
  def new
    @news = News.new
    
    puts "inside the controller#new"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end
  
  
  #first store results in a session, then when the email is verified proerly save
  def create
    
    puts "#{params[:commit]} ****************************************"
  if params[:commit] == "presave"
    
    puts "got into the presave section"
    
    @temp_news = News.new(params[:news])   
    respond_to do |format|

       
         #format.html { redirect_to @temp_news, notice: 'News was successfully created.' }
        

     end
  
  
  else
    
    puts "got into the next stage section"
    
    if @temp_news
      @news = @temp_news
    else
      @news = News.new(params[:news])
    end
    
    @temp_news = nil
    
   respond_to do |format|
     
     if @news.save
       format.html { redirect_to @news, notice: 'News was successfully created.' }
       format.json { render json: @news, status: :created, location: @news }
     else
       format.html { render action: "new" }
       format.json { render json: @news.errors, status: :unprocessable_entity }
     end
     
   end
   
   @temp_news = nil
  end
  
    
    
  end
  
  
  def store
    
    puts 'getting the store'
    @temp_news = News.new(params[:news])
    
  end
  
    
  
  
  
  def edit
    @news = News.find(params[:id])
  end
  
  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end
  

end
