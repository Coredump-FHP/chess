FactoryGirl.define do
  factory :player do
    password '123fsdfsfs'
    password_confirmation '123fsdfsfs'
    sequence :email do |n|
      "fake#{n}@gmail.com"
    end
  end

  factory :game do
    name 'Test'
    association :player
  end
end
