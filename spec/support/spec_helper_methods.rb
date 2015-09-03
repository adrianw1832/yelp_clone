module SpecHelperMethods
  def sign_in_as(user)
    visit('/')
    click_link('Sign in')
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_button('Log in')
  end

  def leave_review
    visit '/restaurants'
    click_link 'Review Goodman'
    fill_in 'Thoughts', with: 'amazing'
    select '5', from: 'Rating'
    click_button 'Leave Review'
  end
end
