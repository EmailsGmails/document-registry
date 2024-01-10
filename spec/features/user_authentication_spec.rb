require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  scenario 'User registration' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_text('Welcome! You have signed up successfully.')
  end

  scenario 'User login' do
    user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'User logout' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit root_path
    click_link 'Logout'
    expect(page).to have_text('Signed out successfully.')
  end
end
