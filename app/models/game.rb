class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  belongs_to :player_1_id, class_name: 'Player'
  belongs_to :player_2_id, class_name: 'Player'
  belongs_to :winning_player_id, class_name: 'Player'
end
