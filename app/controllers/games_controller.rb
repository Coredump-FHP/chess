class GamesController < ApplicationController
  before_action :find_game, only: [:edit, :update, :show]

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
      @game.update_attributes(turn: @game.player_1_id)
      redirect_to root_path
    end
  end

  def edit; end

  def update
    @game.player_2 = current_player
    @game.save
    redirect_to game_path(@game)
  end

  def show; end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :turn)
  end
end
