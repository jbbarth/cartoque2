require "spec_helper"

describe API::HistoryController do
  describe "routing" do
    it "routes to #index" do
      get("/api/history").should route_to("api/history#index", format: "json")
    end
  end
end
