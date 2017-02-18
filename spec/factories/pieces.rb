FactoryGirl.define do
  factory :piece do
    x_coordinate 0
    y_coordinate 0
    association :player
    association :game
    captured false

    factory :pawn do
      player 'player_1'
      color 'white'
      x_coordinate 2
      y_coordinate 2
      type 'Pawn'
    end

    factory :queen do
      player 'player_1'
      color 'white'
      x_coordinate 4
      y_coordinate 1
      type 'Queen'
    end

    factory :knight do
      player 'player_1'
      color 'white'
      x_coordinate 2
      y_coordinate 1
      type 'Knight'
    end

    factory :bishop do
      player 'player_1'
      color 'white'      
      x_coordinate 3
      y_coordinate 1
      type 'Bishop'
    end

    factory :rook do
      player 'player_2'
      color 'black'
      x_coordinate 1
      y_coordinate 1
      type 'Rook'
    end

    factory :king do
      color 'white'
      x_coordinate 5
      y_coordinate 1
      type 'King'
    end
  end
end
