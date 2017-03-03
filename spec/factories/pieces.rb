FactoryGirl.define do
  factory :piece do
    x_coordinate 0
    y_coordinate 0
    association :player
    association :game
    captured false
    icon ''
    color 'white'

    factory :pawn, class: Pawn do
      color 'white'
      x_coordinate 2
      y_coordinate 2
      type 'Pawn'
    end

    factory :queen, class: Queen do
      color 'white'
      x_coordinate 4
      y_coordinate 1
      type 'Queen'
    end

    factory :knight, class: Knight do
      color 'white'
      x_coordinate 2
      y_coordinate 1
      type 'Knight'
    end

    factory :bishop, class: Bishop do
      color 'white'
      x_coordinate 3
      y_coordinate 1
      type 'Bishop'
    end

    factory :rook, class: Rook do
      color 'black'
      x_coordinate 1
      y_coordinate 1
      type 'Rook'
    end

    factory :king, class: King do
      color 'white'
      x_coordinate 5
      y_coordinate 1
      type 'King'
    end
  end
end
