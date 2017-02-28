class PiecesController < ApplicationController
  helper PiecesHelper
  def show
    @piece = Piece.find(params[:id])
    @game = @piece.game
  end

  def update
    piece = Piece.find(params[:id])
    if piece.update(piece_params)
      @game = piece.game
      head :ok, location: @game
    end
  end

  private

  def piece_params
    params.permit(:x_coordinate, :y_coordinate)
  end
end
