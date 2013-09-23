require "spec_helper"

describe HelpController do
  describe "routing" do
    it "routes to #show" do
      get("/help/blah").should route_to("help#show", page: "blah")
    end
  end
end
