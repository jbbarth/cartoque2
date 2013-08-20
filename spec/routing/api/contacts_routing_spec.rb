require "spec_helper"

describe API::ContactsController do
  describe "routing" do
    it "routes to #index" do
      get("/api/contacts").should route_to("api/contacts#index", format: "json")
    end

    it "routes to #new" do
      get("/api/contacts/new").should route_to("api/contacts#new", format: "json")
    end

    it "routes to #show" do
      get("/api/contacts/1").should route_to("api/contacts#show", id: "1", format: "json")
    end

    it "routes to #edit" do
      get("/api/contacts/1/edit").should route_to("api/contacts#edit", id: "1", format: "json")
    end

    it "routes to #create" do
      post("/api/contacts").should route_to("api/contacts#create", format: "json")
    end

    it "routes to #update" do
      put("/api/contacts/1").should route_to("api/contacts#update", id: "1", format: "json")
    end

    it "routes to #destroy" do
      delete("/api/contacts/1").should route_to("api/contacts#destroy", id: "1", format: "json")
    end

  end
end
