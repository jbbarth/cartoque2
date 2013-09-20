require "spec_helper"

#dummy controller, just here for tests..
class API::DummyController < API::ApplicationController
end

describe API::ApplicationController do
  # Fake devise login
  login_user

  before do
    #set-up controller so API::ApplicationController is not used, but Dummy
    @controller = API::DummyController.new
    #add routes for our dummy controller
    Rails.application.routes.draw do
      namespace :api, defaults: { format: 'json' } do
        resources :dummy
      end
    end
  end

  after do
    #reload routes so other specs don't fail
    Rails.application.reload_routes!
  end

  it "rescues ActiveRecord::RecordNotFound errors" do
    API::DummyController.any_instance.stub(:index) { Server.find(0) }
    get :index
    expect(response.code).to eq "404"
    expect(JSON.parse(response.body).keys).to include "message"
  end

  it "rescues ActionView::MissingTemplate errors" do
    API::DummyController.any_instance.stub(:index) { nil }
    get :index
    expect(response.code).to eq "404"
    expect(JSON.parse(response.body).keys).to include "message"
  end

  it "rescues ActionController::ParameterMissing errors" do
    API::DummyController.class_eval { def index; prms = params.require(:nonexistent); end }
    get :index
    expect(response.code).to eq "422"
    hash = JSON.parse(response.body)
    expect(hash.keys).to include "message", "exception"
    expect(hash["exception"]["message"]).to match /nonexistent/
  end

  it "sets the format to JSON if none" do
    API::DummyController.class_eval { def index; render nothing: true; end }
    get :index
    expect(response.headers["Content-Type"]).to match /application\/json/
  end

  it "disables the CSRF protection when the format is JSON" do
    API::DummyController.class_eval { def index; render nothing: true; end }
    API::DummyController.any_instance.should_not_receive(:verify_authenticity_token)
    get :index
  end

  context "#render_error" do
    it "returns a 422 by default" do
      API::DummyController.class_eval { def index; render_error({}); end }
      get :index
      expect(response.code).to eq "422"
    end

    it "allows overriding the status code returned" do
      API::DummyController.class_eval { def index; render_error({status: 666}); end }
      get :index
      expect(response.code).to eq "666"
    end

    it "returns a default hash if nothing provided" do
      API::DummyController.class_eval { def index; render_error({}); end }
      get :index
      json = JSON.parse(response.body)
      expect(json["message"]).to match /error occurred/
    end

    it "allows providing our own hahs as a return value" do
      API::DummyController.class_eval { def index; render_error({json: {message: "Hey"}}); end }
      get :index
      json = JSON.parse(response.body)
      expect(json["message"]).to eq "Hey"
    end
  end
end
