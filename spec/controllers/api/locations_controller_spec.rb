require "spec_helper"

describe API::LocationsController do
  # Fake devise login
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Location. As you add validations to Location, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LocationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # Render views so we can inspect responses
  render_views

  describe "GET index" do
    before do
      location = Location.create! valid_attributes
      get :index, {}, valid_session
      @json = JSON.parse(response.body)
    end

    it "returns a HAL representation of locations as embedded representations" do
      expect(@json["_embedded"].keys).to include "locations"
    end

    it "returns locations as HAL representations witk links etc." do
      expect(@json["_embedded"]["locations"].first.keys).to include "_links"
    end
  end

  describe "GET show" do
    it "returns a JSON representation with HAL additions provided by roar gem" do
      location = Location.create! valid_attributes
      get :show, {id: location.to_param}, valid_session
      json = JSON.parse(response.body)
      expect(json.keys).to include "_links"
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Location" do
        expect {
          post :create, {location: valid_attributes}, valid_session
        }.to change(Location, :count).by(1)
      end

      it "renders the created location" do
        post :create, {location: valid_attributes}, valid_session
        json = JSON.parse(response.body)
        expect(json["name"]).to eq valid_attributes["name"]
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        post :create, {location: { name: "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(response.code).to eq "422"
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested location" do
        location = Location.create! valid_attributes
        Location.any_instance.should_receive(:update).with({ "name" => "shiny-new-name" })
        put :update, {id: location.to_param, location: { "name" => "shiny-new-name" }}, valid_session
      end

      it "return nothing and a 204" do
        location = Location.create! valid_attributes
        put :update, {id: location.to_param, location: { "name" => "new-name" }}, valid_session
        expect(response.code).to eq "204"
        expect(response.body).to eq ""
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        location = Location.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        put :update, {id: location.to_param, location: { "name" => "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(response.code).to eq "422"
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested location" do
      location = Location.create! valid_attributes
      expect {
        delete :destroy, {id: location.to_param}, valid_session
      }.to change(Location, :count).by(-1)
    end

    it "sends a 204 return code" do
      location = Location.create! valid_attributes
      delete :destroy, {id: location.to_param}, valid_session
      expect(response.code).to eq "204"
    end
  end
end
