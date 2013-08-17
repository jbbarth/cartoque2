require "spec_helper"

describe API::RootController do
  # Fake devise login
  login_user

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AppsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # Render views so we can inspect responses
  render_views

  describe "GET index" do
    it "constitutes an entry point for all API topics" do
      get :index, {}, valid_session
      json = JSON.parse(response.body)
      expect(json.keys).to include "_links"
    end
  end
end
