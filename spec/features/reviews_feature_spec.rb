require 'rails_helper'

feature 'reviewing' do
  before do
    user = create(:user)
    create(:restaurant, user: user)
    sign_in_as(user)
  end

  scenario 'allows logged in users to leave a review using a form' do
    leave_review('amazing', '5')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('amazing')
  end

  scenario 'does not allow non logged in user to leave a review' do
    click_link('Sign out')
    visit('/restaurants')
    click_link('Review Goodman')
    expect(page).to have_content('Log in')
  end

  scenario 'user can only leave 1 review per restaurant' do
    leave_review('amazing', '5')
    leave_review('amazing', '5')
    expect(page).to have_content('You have already reviewed this restaurant')
  end

  context 'deleting reviews' do
    before { leave_review('amazing', '5') }

    scenario 'user can delete a review they created' do
      click_link('Delete Review')
      expect(page).not_to have_content 'amazing'
      expect(page).to have_content 'Review deleted successfully'
    end

    scenario 'user cannot delete a review they did not create' do
      click_link('Sign out')
      user2 = create(:user, email: 'test2@test.com')
      sign_in_as(user2)
      visit('/restaurants')
      click_link('Delete Review')
      expect(page).to have_content('Error! You must be the creator to delete this entry.')
    end
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So so', '3')
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end
end
