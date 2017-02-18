FactoryGirl.define do
  factory :piece do
    factory :pawn do
      x_coordinate     '2'
      y_coordinate     '2'
      color 'white'
      game
      type 'Pawn'
    end

    factory :queen do
      x_coordinate     '4'
      y_coordinate     '1'
      color 'white'
      game
      type 'Queen'
    end

    factory :knight do
      x_coordinate     '2'
      y_coordinate     '1'
      color 'white'
      game
      type 'Knight'
    end

    factory :bishop do
      x_coordinate     '3'
      y_coordinate     '1'
      color 'white'
      game
      type 'Bishop'
    end

    factory :rook do
      x_coordinate     '1'
      y_coordinate     '1'
      color 'black'
      game
      type 'Rook'
    end

    factory :king do
      x_coordinate     '5'
      y_coordinate     '1'
      color 'white'
      game
      type 'King'
    end
  end
end
