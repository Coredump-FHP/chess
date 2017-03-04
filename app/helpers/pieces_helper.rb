module PiecesHelper
  def render_piece_highlight(x, y)
    piece = @game.retrieve_piece(x, y)
    return unless piece.present?
    return content_tag(:div, image_tag(piece.icon), class: 'highlight') if piece == @piece
    image_tag(piece.icon)
  end
end
