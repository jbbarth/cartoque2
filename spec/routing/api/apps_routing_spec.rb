require "spec_helper"

describe API::AppsController do
  describe "routing" do
    it "routes to #index" do
      get("/api/apps").should route_to("api/apps#index", :format => "json")
    end

    it "routes to #new" do
      get("/api/apps/new").should route_to("api/apps#new", :format => "json")
    end

    it "routes to #show" do
      get("/api/apps/1").should route_to("api/apps#show", :id => "1", :format => "json")
    end

    it "routes to #edit" do
      get("/api/apps/1/edit").should route_to("api/apps#edit", :id => "1", :format => "json")
    end

    it "routes to #create" do
      post("/api/apps").should route_to("api/apps#create", :format => "json")
    end

    it "routes to #update" do
      put("/api/apps/1").should route_to("api/apps#update", :id => "1", :format => "json")
    end

    it "routes to #destroy" do
      delete("/api/apps/1").should route_to("api/apps#destroy", :id => "1", :format => "json")
    end

  end
end
