class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  belongs_to :user
  has_many :pieces
end
