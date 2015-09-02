require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit('/restaurants')
      expect(page).to have_content('No restaurants yet')
      expect(page).to have_link('Add a restaurant')
    end
  end

  context 'restaurants have been added' do
    before { create(:restaurant) }

    scenario 'display restaurants' do
      visit('/restaurants')
      expect(page).to have_content('Goodman')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    before do
      user = create(:user)
      sign_in_as(user)
    end

    scenario 'user can create restaurants when logged in' do
      visit('/restaurants')
      click_link('Add a restaurant')
      fill_in('Name', with: 'Goodman')
      click_button('Create Restaurant')
      expect(page).to have_content('Goodman')
      expect(current_path).to eq('/restaurants')
    end

    scenario 'user cannot create restaurants when not logged in' do
      click_link('Sign out')
      visit('/')
      click_link('Add a restaurant')
      expect(page).to have_content('Log in')
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end

    scenario 'does not let you submit a name that is too short' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'viewing restaurants' do
    scenario 'lets a user view a restaurant' do
      restaurant = create(:restaurant)
      visit '/restaurants'
      click_link 'Goodman'
      expect(page).to have_content 'Goodman'
      expect(current_path).to eq "/restaurants/#{restaurant.id}"
    end
  end

  context 'editing restaurants' do
    before do
      create(:restaurant)
      user = create(:user)
      sign_in_as(user)
    end

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Goodman'
      fill_in 'Name', with: 'Goodman Steakhouse'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Goodman Steakhouse'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before do
      create(:restaurant)
      user = create(:user)
      sign_in_as(user)
    end

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Goodman'
      expect(page).not_to have_content 'Goodman'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  def sign_in_as(user)
    visit('/')
    click_link('Sign in')
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_button('Log in')
  end
end
