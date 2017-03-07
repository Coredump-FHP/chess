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
    render template: 'games/show'
    # @game.update_attributes(turn: @game.switch_player)
  end

  private

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end

  def your_turn?
    current_player
  end
end
