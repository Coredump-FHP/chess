class PiecesController < ApplicationController
  def show
    @piece = Piece.find(params[:id])
    @game = @piece.game
    # can either set flag here to render a highlight CSS class and then render the games show page again..
    # or we can copy all the view code and show an entirely
    # different view with the board duplicated, then highlight the piece.
    # render "games/show"
  end

  def update; end
end
