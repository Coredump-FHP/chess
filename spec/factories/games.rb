FactoryGirl.define do
  factory :game do
    name 'My Game'

    association :player_1, factory: :player
    association :player_2, factory: :player
  end
end
