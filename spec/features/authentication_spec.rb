require 'spec_helper'

describe 'Authentication' do
  describe 'via a browser' do
    it 'redirects on the sign in page if not authenticated' do
      visit root_path
      current_path.should == new_user_session_path
    end

    it 'accepts authentication' do
      User.create!(email: 'john@example.net', password: 'foobar123')
      visit new_user_session_path

      within '#new_user' do
        fill_in 'user_email', with: 'john@example.net'
        fill_in 'user_password', with: 'foobar123'
        click_button 'Sign in'
      end

      current_path.should == root_path
    end
  end
end
