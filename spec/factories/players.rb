FactoryGirl.define do
  factory :player do
    password 'welcome'
    password_confirmation 'welcome'
    sequence :email do |n|
      "player#{n}@gmail.com"
    end

    factory :player_with_game do
      association :game
    end
  end
end
