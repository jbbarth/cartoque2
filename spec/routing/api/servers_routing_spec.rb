require "spec_helper"

describe API::ServersController do
  describe "routing" do
    it "routes to #index" do
      get("/api/servers").should route_to("api/servers#index")
    end

    it "routes to #new" do
      get("/api/servers/new").should route_to("api/servers#new")
    end

    it "routes to #show" do
      get("/api/servers/1").should route_to("api/servers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/api/servers/1/edit").should route_to("api/servers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/api/servers").should route_to("api/servers#create")
    end

    it "routes to #update" do
      put("/api/servers/1").should route_to("api/servers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/api/servers/1").should route_to("api/servers#destroy", :id => "1")
    end

  end
end
