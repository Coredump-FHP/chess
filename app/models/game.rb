class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  belongs_to :player_1, class_name: 'Player'
  belongs_to :player_2, class_name: 'Player'
  belongs_to :winning_player_id, class_name: 'Player'
end
