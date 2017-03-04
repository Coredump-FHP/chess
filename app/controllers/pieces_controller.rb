class PiecesController < ApplicationController
  helper PiecesHelper
  def show
    @piece = Piece.find(params[:id])
    @game = @piece.game
  end

  def update
    piece = Piece.find(params[:id])
    return unless piece.update(piece_params)
    @game = piece.game
    head :ok, location: @game
  end

  private

  def piece_params
    params.permit(:x_coordinate, :y_coordinate)
  end
end
