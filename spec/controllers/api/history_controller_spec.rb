require "spec_helper"

describe API::HistoryController do
  # Fake devise login
  login_user

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # VersionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # Render views so we can inspect responses
  render_views

  describe "GET index", versioning: true do
    context "with valid item" do
      let(:server) do
        server = Server.create!(name: "server-01")
        server.update_attribute(:name, "server-001")
        server.update_attribute(:name, "server-001-primary")
        server
      end

      it "returns a HAL representation of versions as embedded representations" do
        get :index, { item_type: "Server", item_id: server.id }, valid_session
        json = JSON.parse(response.body)["_embedded"]
        expect(json.keys).to include "versions"
      end
      
      it "returns versions in reverse order" do
        get :index, { item_type: "Server", item_id: server.id }, valid_session
        json = JSON.parse(response.body)["_embedded"]
        expect(json["versions"][0]["object"]).to include "name: server-001\n"
      end
    end

    context "error cases" do
      it "raises an error if object type cannot be found" do
        get :index, { item_type: "Hamburger", item_id: 1 }, valid_session
        expect(response.code).to eq "404"
        expect(JSON.parse(response.body)["message"]).to match /Resource type/
      end

      it "raises an error if object cannot be found" do
        get :index, { item_type: "Server", item_id: 0 }, valid_session
        expect(response.code).to eq "404"
        expect(JSON.parse(response.body)["message"]).to match /Resource or page/
      end
    end
  end
end
