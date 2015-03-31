require 'rails_helper'

RSpec.describe 'Signing in', type: :feature do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  describe 'GET /sessions/new' do
    # before :each do
    #   @sarah_smith = FactoryGirl.create(:user, first_name: 'Sarah', last_name: 'Smith', email: 'abc1@yopmail.com', password: 'testing')
    # end

    it 'should load the home page' do
      visit root_path
    end

    context 'when signed out' do
      it 'should load the page' do
        visit new_session_path
        expect(page).to have_content('Sign in')
      end

      it 'should return an error if email or password is invalid' do
        visit new_session_path

       # within('form') do
          fill_in 'email', with: 'a'
          fill_in 'password', with: 'b'
       # end

        click_button 'Sign in'
        expect(page).to have_content('Invalid email or password')
      end
    end

    context 'when user has no account' do
      it 'should load the home page' do
        visit root_path
        expect(page).to have_content('Sign up')
      end

      it 'should allow the user to sign up' do
        sarah_smith = FactoryGirl.create(:user, first_name: 'Sarah', last_name: 'Smith', email: 'abc1@yopmail.com', password: 'testing')
        visit new_sign_up_path

       # within('form') do
          fill_in 'user_first_name', with: sarah_smith.first_name
          fill_in 'user_last_name', with: sarah_smith.last_name
          fill_in 'user_email', with: 'abc@yopmail.com'
          fill_in 'user_password', with: sarah_smith.password
          fill_in 'user_password_confirmation', with: sarah_smith.password
       # end

        click_button 'Create User'
        expect(page).to have_content('User was successfully created.')
        expect(page).to have_content('Sign out')
        visit root_path
      end

      it 'should display validation if user exist' do
        sarah_smith = FactoryGirl.create(:user, first_name: 'Sarah', last_name: 'Smith', email: 'abc1@yopmail.com', password: 'testing')
        visit new_sign_up_path

       # within('form') do
          fill_in 'user_first_name', with: sarah_smith.first_name
          fill_in 'user_last_name', with: sarah_smith.last_name
          fill_in 'user_email', with: sarah_smith.email
          fill_in 'user_password', with: sarah_smith.password
          fill_in 'user_password_confirmation', with: sarah_smith.password
       # end

        click_button 'Create User'
        expect(page).to have_content('Email has already been taken')
        visit root_path
      end

      it 'should validate no email' do
        sarah_smith = FactoryGirl.create(:user, first_name: 'Sarah', last_name: 'Smith', email: 'abc1@yopmail.com', password: 'testing')
        visit new_sign_up_path

       # within('form') do
          fill_in 'user_first_name', with: sarah_smith.first_name
          fill_in 'user_last_name', with: sarah_smith.last_name
          fill_in 'user_email', with: ' '
          fill_in 'user_password', with: ' '
          fill_in 'user_password_confirmation', with: sarah_smith.password
       # end

        click_button 'Create User'
        expect(page).to have_content('Email is invalid') 
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password can't be blank")
      end

      it 'should validate password does not match' do
        sarah_smith = FactoryGirl.create(:user, first_name: 'Sarah', last_name: 'Smith', email: 'abc1@yopmail.com', password: 'testing')
        visit new_sign_up_path

       # within('form') do
          fill_in 'user_first_name', with: sarah_smith.first_name
          fill_in 'user_last_name', with: sarah_smith.last_name
          fill_in 'user_email', with: sarah_smith.email
          fill_in 'user_password', with: 'abcde'
          fill_in 'user_password_confirmation', with: sarah_smith.password
       # end

        click_button 'Create User'
        expect(page).to have_content("Password confirmation doesn't match Password") 
      end

      it 'should allow the user to sign in after signing up' do
        sarah_smith = FactoryGirl.create(:user, first_name: 'Sarah', last_name: 'Smith', email: 'abc1@yopmail.com', password: 'testing')
        visit new_session_path

       # within('form') do
          fill_in 'email', with: sarah_smith.email
          fill_in 'password', with: sarah_smith.password
       # end

        click_button 'Sign in'
        expect(page).to have_content('Signed in successfully')
        expect(page).to have_content('Sign out')
      end
    end

    context 'when signed in' do
      it 'should allow the user to sign out' do
        visit destroy_session_path
        expect(page).to have_content('Signed out successfully')
      end
    end
  end
end




# require 'rails_helper'
#
# RSpec.describe 'Signing in', :type => :feature do
#   it 'has a valid factory' do
#     expect(FactoryGirl.create(:user_profile)).to be_valid
#   end
#
#   describe 'GET /sessions/new' do
#     before :each do
#       @sarah_smith = FactoryGirl.create(:user_profile, first_name: 'Sarah', last_name: 'Smith')
#     end
#
#     context 'when signed out' do
#       it 'should load the page' do
#         visit new_session_path
#         expect(page).to have_content('Sign In')
#       end
#
#       it 'should allow the user to sign in' do
#         visit new_session_path
#
#         within("form#new_user_profile") do
#           fill_in 'user_profile_email', :with => @sarah_smith.email
#           fill_in 'user_profile_password', :with => @sarah_smith.password
#         end
#
#         click_button 'Sign in'
#         expect(page).to have_content('You have successfully signed in.')
#       end
#     end
#
#     context 'when signed in' do
#       # Sign the user in first
#       before :each do
#         visit new_session_path
#
#         within("#new_user_profile") do
#           fill_in 'user_profile_email', :with => @sarah_smith.email
#           fill_in 'user_profile_password', :with => @sarah_smith.password
#         end
#
#         click_button 'Sign in'
#       end
#
#       it 'should redirect the user' do
#         visit new_session_path
#         expect(current_path).to eq(root_path)
#       end
#     end
#   end
# end
