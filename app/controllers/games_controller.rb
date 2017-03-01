class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    if @game.invalid?
      flash[:error] = 'New game not saved'
    else
      @game.player_1 = current_player
      @game.populate_game!
      redirect_to root_path
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.player_2 = current_player
    @game.save
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
