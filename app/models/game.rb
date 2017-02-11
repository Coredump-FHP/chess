class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  has_many :players

end


