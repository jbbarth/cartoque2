require "spec_helper"

describe API::UsersController do
  # Fake devise login
  login_user

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "email" => "admin@example.net", "password" => "blahblah" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # Render views so we can inspect responses
  render_views

  describe "GET index" do
    before do
      user = User.create! valid_attributes
      get :index, {}, valid_session
      @json = JSON.parse(response.body)
    end

    it "returns a HAL representation of users as embedded representations" do
      expect(@json["_embedded"].keys).to include "users"
    end

    it "returns users as HAL representations witk links etc." do
      expect(@json["_embedded"]["users"].first.keys).to include "_links"
    end
  end

  describe "GET show" do
    it "returns a JSON representation with HAL additions provided by roar gem" do
      user = User.create! valid_attributes
      get :show, {id: user.to_param}, valid_session
      json = JSON.parse(response.body)
      expect(json.keys).to include "_links"
    end

    it "has a blank 'seen_on' attribute when user never logged in" do
      user = User.create! valid_attributes
      get :show, {id: user.to_param}, valid_session
      json = JSON.parse(response.body)
      expect(json["seen_on"]).to eq ""
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {user: valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "renders the created user" do
        post :create, {user: valid_attributes}, valid_session
        json = JSON.parse(response.body)
        expect(json["email"]).to eq valid_attributes["email"]
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {user: { email: "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(response.code).to eq "422"
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        user = User.create! valid_attributes
        User.any_instance.should_receive(:update).with({ "email" => "MyString" })
        put :update, {id: user.to_param, user: { "email" => "MyString" }}, valid_session
      end

      it "return nothing and a 204" do
        user = User.create! valid_attributes
        put :update, {id: user.to_param, user: { "email" => "new-name@example.net" }}, valid_session
        expect(response.code).to eq "204"
        expect(response.body).to eq ""
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        user = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {id: user.to_param, user: { "email" => "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(response.code).to eq "422"
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, {id: user.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "sends a 204 return code" do
      user = User.create! valid_attributes
      delete :destroy, {id: user.to_param}, valid_session
      expect(response.code).to eq "204"
    end
  end
end
