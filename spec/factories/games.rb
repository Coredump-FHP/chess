FactoryGirl.define do
  factory :game do
    name 'My Game'
    association :player
  end
end
