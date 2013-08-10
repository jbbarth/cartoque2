require 'spec_helper'

describe 'Application' do #for global logic across the app..
  before { user = create(:user); login_as user }
  after { logout }

  describe 'global errors' do
    it 'receives a 404 with standard 404 for non-existent URLs' do
      visit '/non-existent'
      expect(page.status_code).to eq 404
      expect(page.body).to match /The page you were looking for/
    end

    it 'returns an empty body for non-html formats' do
      visit '/non-existent.json'
      expect(page.status_code).to eq 404
      expect(page.body).to be_blank
    end
  end
end
