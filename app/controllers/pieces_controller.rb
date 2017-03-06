class PiecesController < ApplicationController
  helper PiecesHelper
  before_action :find_piece
  
  def show
    @game = @piece.game
  end

  def update
    @piece.update_attributes(piece_params)
    @game = @piece.game
    render template: 'games/show'
  end

  private
  
  def find_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end
end
