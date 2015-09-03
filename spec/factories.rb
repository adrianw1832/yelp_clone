FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password 'test1234'
    password_confirmation 'test1234'
  end

  factory :restaurant do
    name 'Goodman'
    rating 5
    user
  end

  factory :review do
    thoughts 'Amazing steak'
    rating 5
  end
end
