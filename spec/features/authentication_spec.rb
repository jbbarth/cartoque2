require 'spec_helper'

describe 'Authentication' do
  after do
    #reset token header, else user will be implicitly
    #logged in between tests, making most tests randomly
    #failing...
    page.set_headers("HTTP_X_API_TOKEN" => nil)
  end

  describe 'via a browser' do
    it 'redirects on the sign in page if not authenticated' do
      visit root_path
      current_path.should == new_user_session_path
    end

    it 'accepts authentication' do
      create(:user)
      visit new_user_session_path

      within '#new_user' do
        fill_in 'user_email', with: 'john@example.net'
        fill_in 'user_password', with: 'foobar123'
        click_button 'Sign in'
      end

      current_path.should == root_path
    end
  end

  describe 'via an API Token' do
    describe 'GET /servers.json', type: :request do
      it 'refuses access if no authentication token given' do
        visit servers_path(format: 'json')
        page.status_code.should == 401
      end

      it 'refuses access if the given authentication token is wrong (blank, too short)' do
        page.set_headers('HTTP_X_API_TOKEN' => 'blah')
        visit servers_path(format: 'json').to_s
        page.status_code.should == 401

        page.set_headers('HTTP_X_API_TOKEN' => '')
        visit servers_path(format: 'json').to_s
        page.status_code.should == 401
      end

      it 'grants access if authentication token is valid' do
        u = create(:user)
        page.set_headers('HTTP_X_API_TOKEN' => u.authentication_token)
        visit servers_path(format: 'json').to_s
        page.status_code.should == 200
      end

      it 'allows access even if not using json/xml/json formats (changed with devise)' do
        u = create(:user)
        page.set_headers('HTTP_X_API_TOKEN' => u.authentication_token)
        visit servers_path(format: 'html').to_s
        page.status_code.should == 200
      end
    end
  end

  describe 'redirection after sign in' do
    let!(:user) { create(:user) }

    it 'redirects back to root path if no back url given' do
      visit new_user_session_path

      within '#new_user' do
        fill_in 'user_email', with: 'john@example.net'
        fill_in 'user_password', with: 'foobar123'
        click_button 'Sign in'
      end

      current_path.should == root_path
    end

    it 'redirects back to stored location if any' do
      visit servers_path
      current_path.should == new_user_session_path

      within '#new_user' do
        fill_in 'user_email', with: 'john@example.net'
        fill_in 'user_password', with: 'foobar123'
        click_button 'Sign in'
      end

      current_path.should == servers_path
    end
  end
end
