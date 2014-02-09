require "spec_helper"

describe API::OperatingSystemsController do
  # Fake devise login
  login_user

  # This should return the minimal set of attributes required to create a valid
  # OperatingSystem. As you add validations to OperatingSystem, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OperatingSystemsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # Render views so we can inspect responses
  render_views

  describe "GET index" do
    before do
      operating_system = OperatingSystem.create! valid_attributes
      get :index, {}, valid_session
      @json = JSON.parse(response.body)
    end

    it "returns a HAL representation of operating_systems as embedded representations" do
      expect(@json["_embedded"].keys).to include "operating_systems"
    end

    it "returns operating_systems as HAL representations witk links etc." do
      expect(@json["_embedded"]["operating_systems"].first.keys).to include "_links"
    end
  end

  describe "GET show" do
    it "returns a JSON representation with HAL additions provided by roar gem" do
      operating_system = OperatingSystem.create! valid_attributes
      get :show, {id: operating_system.to_param}, valid_session
      json = JSON.parse(response.body)
      expect(json.keys).to include "_links"
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new OperatingSystem" do
        expect {
          post :create, {operating_system: valid_attributes}, valid_session
        }.to change(OperatingSystem, :count).by(1)
      end

      it "renders the created operating_system" do
        post :create, {operating_system: valid_attributes}, valid_session
        json = JSON.parse(response.body)
        expect(json["name"]).to eq valid_attributes["name"]
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        # Trigger the behavior that occurs when invalid params are submitted
        OperatingSystem.any_instance.stub(:save).and_return(false)
        post :create, {operating_system: { name: "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(response.code).to eq "422"
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested operating_system" do
        operating_system = OperatingSystem.create! valid_attributes
        OperatingSystem.any_instance.should_receive(:update).with({ "name" => "shiny-new-name" })
        put :update, {id: operating_system.to_param, operating_system: { "name" => "shiny-new-name" }}, valid_session
      end

      it "return nothing and a 204" do
        operating_system = OperatingSystem.create! valid_attributes
        put :update, {id: operating_system.to_param, operating_system: { "name" => "new-name" }}, valid_session
        expect(response.code).to eq "204"
        expect(response.body).to eq ""
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        operating_system = OperatingSystem.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        OperatingSystem.any_instance.stub(:save).and_return(false)
        put :update, {id: operating_system.to_param, operating_system: { "name" => "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(response.code).to eq "422"
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested operating_system" do
      operating_system = OperatingSystem.create! valid_attributes
      expect {
        delete :destroy, {id: operating_system.to_param}, valid_session
      }.to change(OperatingSystem, :count).by(-1)
    end

    it "sends a 204 return code" do
      operating_system = OperatingSystem.create! valid_attributes
      delete :destroy, {id: operating_system.to_param}, valid_session
      expect(response.code).to eq "204"
    end
  end
end
