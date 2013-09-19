require "spec_helper"

describe API::<%= class_name.pluralize %>Controller do
  describe "routing" do
    it "routes to #index" do
      get("/api/<%= plural_name %>").should route_to("api/<%= plural_name %>#index", format: "json")
    end

    it "routes to #new" do
      get("/api/<%= plural_name %>/new").should route_to("api/<%= plural_name %>#new", format: "json")
    end

    it "routes to #show" do
      get("/api/<%= plural_name %>/1").should route_to("api/<%= plural_name %>#show", id: "1", format: "json")
    end

    it "routes to #edit" do
      get("/api/<%= plural_name %>/1/edit").should route_to("api/<%= plural_name %>#edit", id: "1", format: "json")
    end

    it "routes to #create" do
      post("/api/<%= plural_name %>").should route_to("api/<%= plural_name %>#create", format: "json")
    end

    it "routes to #update" do
      put("/api/<%= plural_name %>/1").should route_to("api/<%= plural_name %>#update", id: "1", format: "json")
    end

    it "routes to #destroy" do
      delete("/api/<%= plural_name %>/1").should route_to("api/<%= plural_name %>#destroy", id: "1", format: "json")
    end

  end
end
