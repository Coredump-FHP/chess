FactoryGirl.define do
  factory :piece do
    x_coordinate 0
    y_coordinate 0
    association :player
    association :game
    captured false
    color 'white'

    factory :pawn do
      player 'player_1'
      x_coordinate 2
      y_coordinate 2
      type 'Pawn'
      color 'black'
    end

    factory :queen do
      player 'player_1'
      x_coordinate 4
      y_coordinate 1
      type 'Queen'
    end

    factory :knight do
      player 'player_1'
      x_coordinate 2
      y_coordinate 1
      type 'Knight'
    end

    factory :bishop do
      player 'player_1'
      x_coordinate 3
      y_coordinate 1
      type 'Bishop'
    end

    factory :rook do
      player 'player_2'
      x_coordinate 1
      y_coordinate 1
      type 'Rook'
    end

    factory :king do
      x_coordinate 5
      y_coordinate 1
      type 'King'
    end
  end
end
