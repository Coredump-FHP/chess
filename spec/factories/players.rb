FactoryGirl.define do
  factory :player do
    sequence :email do |n|
      "fake#{n}@gmail.com"
    end
    password '123fsdfsfs'
    password_confirmation '123fsdfsfs'
  end
end
