require "spec_helper"

describe API::ContactsController do
  # Fake devise login
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Contact. As you add validations to Contact, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContactsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # Render views so we can inspect responses
  render_views

  describe "GET index" do
    before do
      contact = Contact.create! valid_attributes
      get :index, {}, valid_session
      @json = JSON.parse(response.body)
    end

    it "returns a HAL representation of contacts as embedded representations" do
      expect(@json["_embedded"].keys).to include "contacts"
    end

    it "returns contacts as HAL representations witk links etc." do
      expect(@json["_embedded"]["contacts"].first.keys).to include "_links"
    end
  end

  describe "GET show" do
    it "returns a JSON representation with HAL additions provided by roar gem" do
      contact = Contact.create! valid_attributes
      get :show, {id: contact.to_param}, valid_session
      json = JSON.parse(response.body)
      expect(json.keys).to include "_links"
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Contact" do
        expect {
          post :create, {:contact => valid_attributes}, valid_session
        }.to change(Contact, :count).by(1)
      end

      it "renders the created contact" do
        post :create, {:contact => valid_attributes}, valid_session
        json = JSON.parse(response.body)
        expect(json["name"]).to eq valid_attributes["name"]
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        post :create, {:contact => { :name => "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested contact" do
        contact = Contact.create! valid_attributes
        Contact.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => contact.to_param, :contact => { "name" => "MyString" }}, valid_session
      end

      it "renders the updated contact" do
        post :create, {:contact => { :name => "srv-new-name" }}, valid_session
        json = JSON.parse(response.body)
        expect(json["name"]).to eq "srv-new-name"
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        contact = Contact.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        put :update, {:id => contact.to_param, :contact => { "name" => "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, {:id => contact.to_param}, valid_session
      }.to change(Contact, :count).by(-1)
    end

    it "sends a 204 return code" do
      contact = Contact.create! valid_attributes
      delete :destroy, {:id => contact.to_param}, valid_session
      expect(response.code).to eq "204"
    end
  end
end
