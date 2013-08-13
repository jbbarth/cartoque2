require 'spec_helper'

describe API::AppsController do
  # Fake devise login
  login_user

  # This should return the minimal set of attributes required to create a valid
  # App. As you add validations to App, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AppsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # Render views so we can inspect responses
  render_views

  describe "GET index" do
    it "returns a JSON representation with HAL additions provided by roar gem" do
      app = App.create! valid_attributes
      get :index, {}, valid_session
      json = JSON.parse(response.body)
      expect(json.detect{|s|s['id'] == app.id}.keys).to include '_links'
    end
  end

  describe "GET show" do
    it "returns a JSON representation with HAL additions provided by roar gem" do
      app = App.create! valid_attributes
      get :show, {id: app.to_param}, valid_session
      json = JSON.parse(response.body)
      expect(json.keys).to include '_links'
    end
  end
end
