class NewsController < ApplicationController
  
  def val_new_news
  
   #super simple authentication just to make sure there is an email in the db
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
  
  
  def val_edit_news
        
    @news = News.find(params[:id])

    if Player.find(:first, :conditions => [ "email = ?", params[:email]])
 
      if @news.update_attributes(:title => params[:title], :description => params[:description])
       
        respond_to do |format|
          format.html { redirect_to @news }
          format.json { head :ok }
        end
      else
        logger.debug "failed"
        respond_to do |format|
          format.html { render action: "edit" }
          format.json { render json: @news.errors, status: :unprocessable_entity }
        end
      end

    else
      logger.debug "nothing"
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
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end
 
  def edit
    logger.debug "in the edit method"
    @news = News.find(params[:id])
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
