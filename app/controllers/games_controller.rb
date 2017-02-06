class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
      if @game.invalid?
        flash[:error] = 'New game not saved'
      end
    redirect_to root_path
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

end
