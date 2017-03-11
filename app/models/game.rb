# noinspection ALL
class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  belongs_to :player_1, class_name: 'Player', optional: true
  belongs_to :player_2, class_name: 'Player', optional: true
  belongs_to :winning_player, class_name: 'Player', optional: true
  belongs_to :active_player, class_name: 'Player', optional: true

  scope :available, lambda {
                      where('player_1_id IS NOT NULL AND player_2_id IS NULL')
                        .or(Game.where('player_1_id IS NULL AND player_2_id IS NOT NULL'))
                    }

  def retrieve_piece(x, y)
    pieces.find_by(x_coordinate: x, y_coordinate: y)
  end

  def render_piece(x, y)
    piece = retrieve_piece(x, y)
    return nil if piece.nil?
    piece.icon
  end

  # Populate a game with all the pieces in the correct locations (x_coordinate, y_coordinate)
  def populate_game!
    return unless pieces.count.zero?
    add_starting_pieces_for_color!('white')
    add_starting_pieces_for_color!('black')
    save
  end

  def check?
    # suppose we have a king at a fixed arbitrary location
    # we will need to verify if any of the opponent player's chess can capture the king
    # if any of the following chess pieces is able to capture the king...
    # we will just short-circuit it and return true

    # just some thoughts... we can iterate through all the opponent player's pieces, and check if each has a valid_move towards the king, and if it does have a valid_move, then it means that it can caputer the king if it wants to.

    # self is going to be the game
    # game.check?
    white_king = pieces.where(type: 'King').where(color: 'white').first
    black_pieces = pieces.where(color: 'black')

    black_pieces.each do |black_piece|
      if black_piece.valid_move?(white_king.x_coordinate, white_king.y_coordinate)
        return true
      end
    end

    black_king = pieces.where(type: 'King').where(color: 'black').first
    white_pieces = pieces.where(color: 'white')

    white_pieces.each do |white_piece|
      return true if white_piece.valid_move?(black_king.x_coordinate, black_king.y_coordinate)
    end

    # if none of the above chess pieces is able to capture the king, we will return false
    false
  end

  def inactive_player
    return player_1_id if turn == player_2_id
    return player_2_id if turn == player_1_id
  end

  def not_your_turn
    !inactive_player
  end

  private

  def add_starting_pieces_for_color!(color)
    if color == 'white'
      king_row = 0
      pawn_row = 1
    else
      king_row = 7
      pawn_row = 6
    end

    (0..7).each do |i|
      create_piece!(color, i, pawn_row, 'Pawn', "pawn-#{color}.png")
    end
    create_piece!(color, 0, king_row, 'Rook', "rook-#{color}.png")
    create_piece!(color, 1, king_row, 'Knight', "knight-#{color}.png")
    create_piece!(color, 2, king_row, 'Bishop', "bishop-#{color}.png")
    create_piece!(color, 3, king_row, 'Queen', "queen-#{color}.png")
    create_piece!(color, 4, king_row, 'King', "king-#{color}.png")
    create_piece!(color, 5, king_row, 'Bishop', "bishop-#{color}.png")
    create_piece!(color, 6, king_row, 'Knight', "knight-#{color}.png")
    create_piece!(color, 7, king_row, 'Rook', "rook-#{color}.png")
  end

  def create_piece!(color, row, col, piece, icon)
    pieces << Piece.create(
      game: self,
      player: color == 'white' ? player_1 : player_2,
      color: color == 'white' ? 0 : 1,
      x_coordinate: row,
      y_coordinate: col,
      type: piece,
      icon: icon,
      captured: false
    )
  end
end
