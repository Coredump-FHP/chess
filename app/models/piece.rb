class Piece < ApplicationRecord
  belongs_to :player, class_name: 'Player', optional: true
  belongs_to :game

  # we should not name a column "type", but this gets around the problem
  # http://apidock.com/rails/ActiveRecord/Base/inheritance_column/class
  # disable STI
  self.inheritance_column = :_type_disabled

  enum color: %w(white black)
end
