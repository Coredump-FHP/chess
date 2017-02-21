class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    if @game.invalid?
      flash[:error] = 'New game not saved'
      redirect_to root_path
    else
      @game.player_1_id = current_player.id
      @game.save
      @game.populate_game!
      redirect_to root_path
   end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.player_2_id = current_player.id
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
