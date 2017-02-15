FactoryGirl.define do
  factory :game do
    name 'Game'
    association :player
  end
end
