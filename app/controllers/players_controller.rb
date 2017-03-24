class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
  end

  private

  def games_won
    Game.where(winning_player_id: self).count
  end

  def games_lost
    Game.where(winning_player_id: !self).count
  end
  
end
