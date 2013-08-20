require "spec_helper"

describe API::UsersController do
  describe "routing" do
    it "routes to #index" do
      get("/api/users").should route_to("api/users#index", format: "json")
    end

    it "routes to #new" do
      get("/api/users/new").should route_to("api/users#new", format: "json")
    end

    it "routes to #show" do
      get("/api/users/1").should route_to("api/users#show", id: "1", format: "json")
    end

    it "routes to #edit" do
      get("/api/users/1/edit").should route_to("api/users#edit", id: "1", format: "json")
    end

    it "routes to #create" do
      post("/api/users").should route_to("api/users#create", format: "json")
    end

    it "routes to #update" do
      put("/api/users/1").should route_to("api/users#update", id: "1", format: "json")
    end

    it "routes to #destroy" do
      delete("/api/users/1").should route_to("api/users#destroy", id: "1", format: "json")
    end

  end
end
