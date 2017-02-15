FactoryGirl.define do
  factory :piece do
    factory :pawn do
      x_coordinate     '2'
      y_coordinate     '2'
      color 'white'
      game
    end

    factory :queen do
      x_coordinate     '4'
      y_coordinate     '1'
      color 'white'
      game
    end

    factory :knight do
      x_coordinate     '2'
      y_coordinate     '1'
      color 'white'
      game
    end

    factory :bishop do
      x_coordinate     '3'
      y_coordinate     '1'
      color 'white'
      game
    end

    factory :rook do
      x_coordinate     '1'
      y_coordinate     '1'
      color 'black'
      game
    end

    factory :king do
      x_coordinate     '5'
      y_coordinate     '1'
      color 'white'
      game
    end
  end
end
