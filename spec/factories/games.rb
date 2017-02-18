FactoryGirl.define do
  factory :game do
    name 'Game'
    association :player_1
    association :player_2
  end
end
