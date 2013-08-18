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
    let(:json) do
      get :index, {}, valid_session
      JSON.parse(response.body)
    end

    it "constitutes an entry point for all API topics" do
      expect(json.keys).to include "_links"
    end

    it "contains a link to all resource controller present in app/controllers/api/" do
      controllers = Dir.glob(Rails.root.join("app/controllers/api/*.rb"))
      resources   = controllers.map{|c| File.basename(c).sub("_controller.rb", "") }
      exceptions  = %w(application root) # they don't correspond to resources..
      resources  -= exceptions
      resources  += %w(self) # add "self", present in json response, so that the assertion is prettier
      expect(json["_links"].keys.sort).to eq resources.sort
    end
  end
end
