require 'rails_helper'

feature 'reviewing' do
  before do
    user = create(:user)
    create(:restaurant, user: user)
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Goodman'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
end
