require "spec_helper"

describe API::<%= class_name.pluralize %>Controller do
  # Fake devise login
  login_user

  # This should return the minimal set of attributes required to create a valid
  # <%= class_name %>. As you add validations to <%= class_name %>, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # <%= class_name %>sController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # Render views so we can inspect responses
  render_views

  describe "GET index" do
    before do
      <%= singular_name %> = <%= class_name %>.create! valid_attributes
      get :index, {}, valid_session
      @json = JSON.parse(response.body)
    end

    it "returns a HAL representation of <%= plural_name %> as embedded representations" do
      expect(@json["_embedded"].keys).to include "<%= plural_name %>"
    end

    it "returns <%= plural_name %> as HAL representations witk links etc." do
      expect(@json["_embedded"]["<%= plural_name %>"].first.keys).to include "_links"
    end
  end

  describe "GET show" do
    it "returns a JSON representation with HAL additions provided by roar gem" do
      <%= singular_name %> = <%= class_name %>.create! valid_attributes
      get :show, {id: <%= singular_name %>.to_param}, valid_session
      json = JSON.parse(response.body)
      expect(json.keys).to include "_links"
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new <%= class_name %>" do
        expect {
          post :create, {<%= singular_name %>: valid_attributes}, valid_session
        }.to change(<%= class_name %>, :count).by(1)
      end

      it "renders the created <%= singular_name %>" do
        post :create, {<%= singular_name %>: valid_attributes}, valid_session
        json = JSON.parse(response.body)
        expect(json["name"]).to eq valid_attributes["name"]
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        # Trigger the behavior that occurs when invalid params are submitted
        <%= class_name %>.any_instance.stub(:save).and_return(false)
        post :create, {<%= singular_name %>: { name: "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(response.code).to eq "422"
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested <%= singular_name %>" do
        <%= singular_name %> = <%= class_name %>.create! valid_attributes
        <%= class_name %>.any_instance.should_receive(:update).with({ "name" => "shiny-new-name" })
        put :update, {id: <%= singular_name %>.to_param, <%= singular_name %>: { "name" => "shiny-new-name" }}, valid_session
      end

      it "return nothing and a 204" do
        <%= singular_name %> = <%= class_name %>.create! valid_attributes
        put :update, {id: <%= singular_name %>.to_param, <%= singular_name %>: { "name" => "new-name" }}, valid_session
        expect(response.code).to eq "204"
        expect(response.body).to eq ""
      end
    end

    describe "with invalid params" do
      it "returns an error message" do
        <%= singular_name %> = <%= class_name %>.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        <%= class_name %>.any_instance.stub(:save).and_return(false)
        put :update, {id: <%= singular_name %>.to_param, <%= singular_name %>: { "name" => "invalid value" }}, valid_session
        json = JSON.parse(response.body)
        expect(response.code).to eq "422"
        expect(json.keys).to include "message", "errors"
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested <%= singular_name %>" do
      <%= singular_name %> = <%= class_name %>.create! valid_attributes
      expect {
        delete :destroy, {id: <%= singular_name %>.to_param}, valid_session
      }.to change(<%= class_name %>, :count).by(-1)
    end

    it "sends a 204 return code" do
      <%= singular_name %> = <%= class_name %>.create! valid_attributes
      delete :destroy, {id: <%= singular_name %>.to_param}, valid_session
      expect(response.code).to eq "204"
    end
  end
end
