require "spec_helper"

describe API::LocationsController do
  describe "routing" do
    it "routes to #index" do
      get("/api/locations").should route_to("api/locations#index", format: "json")
    end

    it "routes to #new" do
      get("/api/locations/new").should route_to("api/locations#new", format: "json")
    end

    it "routes to #show" do
      get("/api/locations/1").should route_to("api/locations#show", id: "1", format: "json")
    end

    it "routes to #edit" do
      get("/api/locations/1/edit").should route_to("api/locations#edit", id: "1", format: "json")
    end

    it "routes to #create" do
      post("/api/locations").should route_to("api/locations#create", format: "json")
    end

    it "routes to #update" do
      put("/api/locations/1").should route_to("api/locations#update", id: "1", format: "json")
    end

    it "routes to #destroy" do
      delete("/api/locations/1").should route_to("api/locations#destroy", id: "1", format: "json")
    end

  end
end
