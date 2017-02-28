module PiecesHelper
  def render_piece_highlight(x, y)
    piece = @game.retrieve_piece(x, y)
    if !piece.nil?
      if piece == @piece
        return content_tag(:div, image_tag(piece.icon), class: 'highlight')
      else
        return image_tag(piece.icon)
      end
    else
      return link_to(raw(content_tag(:div, ' ', class: 'clickable-square')), piece_path(@piece, x_coordinate: x, y_coordinate: y), method: 'PUT')
    end
  end
end
