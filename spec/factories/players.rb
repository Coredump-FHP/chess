FactoryGirl.define do
  factory :player, aliases: [:player_1, :player_2] do
    sequence :email do |n|
      "player#{n}@gmail.com"
    end

    password 'welcome'
    password_confirmation 'welcome'
  end

  factory :player_with_game do
    association :game
  end
end
