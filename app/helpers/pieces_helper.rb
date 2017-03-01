module PiecesHelper
  def render_piece_highlight(x, y)
    piece = @game.retrieve_piece(x, y)
    return unless piece.present?
    if piece == @piece
      return content_tag(:div, image_tag(piece.icon), class: 'highlight')
    else
      return image_tag(piece.icon)
    end
    link_to(raw(content_tag(:div, ' ', class: 'clickable-square')), piece_path(@piece, x_coordinate: x, y_coordinate: y), method: 'PUT')
    end
  end
end
