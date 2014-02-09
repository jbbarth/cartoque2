require 'spec_helper'
require 'will_paginate/array'

describe API::OperatingSystemsRepresenter do
  let(:operating_systems) do
    operating_systems = []
    operating_systems << create(:operating_system, name: "srv-01")
    operating_systems << create(:operating_system, name: "srv-02")
    operating_systems.paginate.extend(API::OperatingSystemsRepresenter)
  end
  let(:operating_systems_json) { JSON.parse(operating_systems.to_json) }

  describe '#to_json' do
    it "contains operating_systems as embedded objects" do
      expect(operating_systems_json["_embedded"].keys).to include "operating_systems"
    end

    it "contains all operating_systems" do
      names = operating_systems_json["_embedded"]["operating_systems"].map{|repr| repr["name"]}
      expect(names).to include "srv-01", "srv-02"
    end

    it "exposes a link to API operating_systems index" do
      expect(operating_systems_json["_links"]["self"]["href"]).to eq "/api/operating_systems?page=1"
    end

    it "exposes a link to create action" do
      expect(operating_systems_json["_links"]["create"]["href"]).to eq "/api/operating_systems"
      expect(operating_systems_json["_links"]["create"]["method"]).to eq "POST"
    end
  end
end
