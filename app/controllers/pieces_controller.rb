class PiecesController < ApplicationController
  helper PiecesHelper
  def show
    @piece = Piece.find(params[:id])
    @game = @piece.game
  end

  def update
    @piece = Piece.find(params[:id])
    @piece.update_attributes(piece_params)
    @game = @piece.game
    if @game.not_your_turn
      flash[:error] = 'Not your turn!'
    else
      @game.update_attributes!(turn: @game.inactive_player)
      render template: 'games/show'
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end
end
