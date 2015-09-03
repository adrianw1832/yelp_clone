require 'rails_helper'

RSpec.describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }

  it { is_expected.to belong_to :user }

  it 'is invalid if the rating is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end

describe 'Review' do
  context 'deleting reviews' do
    it 'can be deleted by its creator' do
      user = create(:user)
      review = create(:review, user: user)
      review.destroy_as_user(user)
      expect(Review.first).to be nil
    end

    it 'cannot be deleted by someone else' do
      user = create(:user)
      review = create(:review, user: user)
      user2 = create(:user, email: 'test2@test.com')
      review.destroy_as_user(user2)
      expect(Review.last).to eq review
    end
  end
end
