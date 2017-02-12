class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  belongs_to :player_1, class_name: 'Player'
  belongs_to :player_1, class_name: 'Player'
  belongs_to :winning_user, class_name: 'Player'
end
