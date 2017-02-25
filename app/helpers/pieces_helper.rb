module PiecesHelper
  def render_piece_highlight(x, y)
    piece = @game.retrieve_piece(x, y)
    if !piece.nil?
      if piece == @piece
        return content_tag(:div, image_tag(piece.icon), class: 'highlight' )
      else
        return image_tag(piece.icon)
      end
    else 
      return content_tag(:div, link_to('click me', piece_path(x_coordinate: x, y_coordinate:y)), class: 'highlight' )
    end    
  end
end
