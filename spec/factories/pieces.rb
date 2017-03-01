FactoryGirl.define do
  factory :piece do
    x_coordinate 0
    y_coordinate 0
    association :player
    association :game
    captured false
    icon ''
    color 'white'
    # http://stackoverflow.com/questions/13343876/how-to-define-factories-with-a-inheritance-user-model
    factory :king, class: King, parent: :piece do
    end

    factory :queen do
      player 'player_1'
      x_coordinate 4
      y_coordinate 1
      type 'Queen'
    end

    factory :bishop, class: Bishop, parent: :piece do
    end

    factory :knight, class: Knight, parent: :piece do
    end

    factory :rook do
      player 'player_2'
      x_coordinate 1
      y_coordinate 1
      type 'Rook'
    end

    factory :pawn do
      player 'player_1'
      x_coordinate 2
      y_coordinate 2
      type 'Pawn'
      color 'black'
    end
  end
end
