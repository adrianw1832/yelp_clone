require 'rails_helper'

feature 'reviewing' do
  before do
    user = create(:user)
    create(:restaurant, user: user)
    sign_in_as(user)
  end

  scenario 'allows logged in users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Goodman'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'does not allow non logged in user to leave a review' do
    click_link('Sign out')
    visit('/restaurants')
    click_link('Review Goodman')
    expect(page).to have_content('Log in')
  end

  scenario 'user can only leave 1 review per restaurant' do
    visit '/restaurants'
    click_link 'Review Goodman'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    visit '/restaurants'
    click_link 'Review Goodman'
    expect(page).to have_content('You have already reviewed this restaurant')
  end
end
