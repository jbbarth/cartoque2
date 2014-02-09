require "spec_helper"

describe API::OperatingSystemsController do
  describe "routing" do
    it "routes to #index" do
      get("/api/operating_systems").should route_to("api/operating_systems#index", format: "json")
    end

    it "routes to #new" do
      get("/api/operating_systems/new").should route_to("api/operating_systems#new", format: "json")
    end

    it "routes to #show" do
      get("/api/operating_systems/1").should route_to("api/operating_systems#show", id: "1", format: "json")
    end

    it "routes to #edit" do
      get("/api/operating_systems/1/edit").should route_to("api/operating_systems#edit", id: "1", format: "json")
    end

    it "routes to #create" do
      post("/api/operating_systems").should route_to("api/operating_systems#create", format: "json")
    end

    it "routes to #update" do
      put("/api/operating_systems/1").should route_to("api/operating_systems#update", id: "1", format: "json")
    end

    it "routes to #destroy" do
      delete("/api/operating_systems/1").should route_to("api/operating_systems#destroy", id: "1", format: "json")
    end

  end
end
