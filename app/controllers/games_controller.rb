class GamesController < ApplicationController
  def new
    @game = Game.new
      @game.save
      @game.add_white_starting_pieces!
      @game.add_black_starting_pieces!
  end

  def create
    @game = Game.create(game_params)

    flash[:error] = 'New game not saved' if @game.invalid?
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
