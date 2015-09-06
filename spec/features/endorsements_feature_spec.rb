require 'rails_helper'

feature 'endorsing reviews' do
  before do
    user = build(:user)
    goodman = create(:restaurant)
    goodman.reviews.create(rating: 3, thoughts: 'It was an abomination', user: user)
  end

  scenario 'starts with no endorsements' do
    visit '/restaurants'
    expect(page).to have_content('0 endorsements')
  end

  it 'a user can endorse a review, which increments the endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content("1 endorsement")
  end  
end
