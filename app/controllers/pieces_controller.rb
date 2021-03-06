class PiecesController < ApplicationController
  helper PiecesHelper
  before_action :find_piece

  def show
    @game = @piece.game
  end

  def update
    @piece.update_attributes(piece_params)
    @game = @piece.game
    if @game.winning_player_id.present?
      flash[:error] = 'Game is over!'
    elsif @game.not_your_turn
      flash[:error] = 'Not your turn!'
    else
      @game.update_attributes!(turn: @game.inactive_player)
      render template: 'games/show'
    end
  end

  private

  def find_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.permit(:x_coordinate, :y_coordinate)
  end
end
