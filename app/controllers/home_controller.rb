class HomeController < ApplicationController
  def index
    
    @news = News.all
    @fixtures = Match.fixtures
    @latest_results = Match.latest_results
    @latest_news = News.latest_news
  end

end
