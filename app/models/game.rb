class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  belongs_to :player
  has_many :pieces
end


