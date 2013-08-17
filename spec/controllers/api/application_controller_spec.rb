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

  it "sets the format to JSON if none" do
    API::DummyController.class_eval { def index; render nothing: true; end }
    get :index
    expect(response.headers["Content-Type"]).to match /application\/json/
  end
end