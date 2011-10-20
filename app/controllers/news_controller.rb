class NewsController < ApplicationController
  # GET /news
  # GET /news.json
  def index
    @news = News.all

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
  
  # GET /tests/new
  # GET /tests/new.json
  def new
    @news = News.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end
  
  def create
   @news = News.new(params[:news])

   respond_to do |format|
     if @news.save
       format.html { redirect_to @news, notice: 'News was successfully created.' }
       format.json { render json: @news, status: :created, location: @news }
     else
       format.html { render action: "new" }
       format.json { render json: @news.errors, status: :unprocessable_entity }
     end
   end
  end
  
  

end
