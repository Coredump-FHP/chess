class GamesController < ApplicationController
  def new
    @game = Game.new
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
    params.require(:game).permit(:name, :player_1_user_id, :player_2_user_id, :winning_user_id)
  end
end
