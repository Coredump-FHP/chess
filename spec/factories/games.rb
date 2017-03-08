FactoryGirl.define do
  factory :game do
    name 'My Game'
    turn '1'

    association :player_1, factory: :player
    association :player_2, factory: :player
  end
end
