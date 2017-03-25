class PiecesController < ApplicationController
  helper PiecesHelper
  before_action :find_piece

  def show
    @game = @piece.game
  end

  def update
    @piece.update_attributes(piece_params)
    color = @piece.color
    @game = @piece.game
    if @game.not_your_turn
      flash[:error] = 'Not your turn!'
    else
      @game.update_attributes!(turn: @game.inactive_player)
      render template: 'games/show'
    end
    head :bad_request

    if @game.check(color)?
      flash[:error] = 'Check!'
    end
  end

  private

  def find_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:x_coordinate, :y_coordinate)
  end
end
