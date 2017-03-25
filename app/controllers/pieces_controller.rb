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
      return head :ok, location: @game
    end
    head :bad_request

    if @game.check?
      flash[:error] = 'Check!'
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end
end
