FactoryGirl.define do
  factory :piece do
    x_coordinate 0
    y_coordinate 0
    association :player
    association :game
    captured false
    icon ''
    color 'white'

    factory :pawn, class: Pawn, parent: :piece do
    end

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

    factory :queen, class: Queen, parent: :piece do
    end

    factory :rook do
      player 'player_2'
      x_coordinate 1
      y_coordinate 1
      type 'Rook'
    end
  end
end
