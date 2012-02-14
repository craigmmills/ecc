class PlayersController < ApplicationController
  def index
    
    @players = Player.player_list

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players }
    end
    
  end

  def show
    
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
    
  end

end
