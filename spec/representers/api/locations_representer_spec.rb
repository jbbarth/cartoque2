require 'spec_helper'
require 'will_paginate/array'

describe API::LocationsRepresenter do
  let(:locations) do
    locations = []
    locations << create(:location, name: "srv-01")
    locations << create(:location, name: "srv-02")
    locations.paginate.extend(API::LocationsRepresenter)
  end
  let(:locations_json) { JSON.parse(locations.to_json) }

  describe '#to_json' do
    it "contains locations as embedded objects" do
      expect(locations_json["_embedded"].keys).to include "locations"
    end

    it "contains all locations" do
      names = locations_json["_embedded"]["locations"].map{|repr| repr["name"]}
      expect(names).to include "srv-01", "srv-02"
    end

    it "exposes a link to API locations index" do
      expect(locations_json["_links"]["self"]["href"]).to eq "/api/locations?page=1"
    end

    it "exposes a link to create action" do
      expect(locations_json["_links"]["create"]["href"]).to eq "/api/locations"
      expect(locations_json["_links"]["create"]["method"]).to eq "POST"
    end
  end
end
