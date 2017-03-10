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
      @game.update_attributes(turn: @game.player_1_id)
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

  def forfeit
    current_game.forfeit(current_player_id)
    flash[:alert] = 'You have forfeitted the game, #{User.find(current_game.winning_player_id).email} wins the game.'
    redirect_to games_path
  end


  private

  def current_game
    @game ||= Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :turn)
  end
end
