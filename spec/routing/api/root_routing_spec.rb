require "spec_helper"

describe API::RootController do
  describe "routing" do
    it "routes API root to #index" do
      get("/api").should route_to("api/root#index", :format => "json")
    end
  end
end
