FactoryGirl.define do
  factory :endorsement do
    review nil
  end

  factory :user do
    email 'test@test.com'
    password 'test1234'
    password_confirmation 'test1234'
  end

  factory :restaurant do
    name 'Goodman'
    user
  end

  factory :review do
    thoughts 'Amazing steak'
    rating 5
    restaurant
  end
end
