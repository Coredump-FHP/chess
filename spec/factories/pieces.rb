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

    # http://stackoverflow.com/questions/13343876/how-to-define-factories-with-a-inheritance-user-model
    factory :king, class: King, parent: :piece do
    end

    factory :bishop, class: Bishop, parent: :piece do
    end

    factory :knight, class: Knight do
      color 'white'
      x_coordinate 2
      y_coordinate 1
      type 'Knight'
    end

    factory :queen, class: Queen, parent: :piece do
    end

    factory :rook, class: Rook do
      color 'black'

      x_coordinate 1
      y_coordinate 1
      type 'Rook'
    end
  end
end
