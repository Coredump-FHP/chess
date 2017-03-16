class PiecesController < ApplicationController
  helper PiecesHelper
  before_action :find_piece

  def show
    @game = @piece.game
  end

  def update
    piece = Piece.find(params[:id])
    if piece.update(piece_params)
      @game = piece.game
      return head :ok, location: @game
    end
    head :bad_request
  end

  private

  def find_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end
end
