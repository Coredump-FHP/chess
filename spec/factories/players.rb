FactoryGirl.define do
  factory :player_1 do
    password '123fsdfsfs'
    password_confirmation '123fsdfsfs'
    sequence :email do |n|
      "fake#{n}@gmail.com"
    end
  end
  factory :player_2 do
    password '123fsdfsfs'
    password_confirmation '123fsdfsfs'
    sequence :email do |n|
      "fake#{n}@gmail.com"
    end
  end

end
