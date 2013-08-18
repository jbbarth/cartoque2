require 'spec_helper'

describe API::AppsRepresenter do
  let(:apps) do
    apps = []
    apps << create(:app, name: "app-01")
    apps << create(:app, name: "app-02")
    apps.extend(API::AppsRepresenter)
  end
  let(:apps_json) { JSON.parse(apps.to_json) }

  describe '#to_json' do
    it "contains apps as embedded objects" do
      expect(apps_json["_embedded"].keys).to include "apps"
    end

    it "contains all apps" do
      names = apps_json["_embedded"]["apps"].map{|repr| repr["name"]}
      expect(names).to include "app-01", "app-02"
    end

    it "exposes a link to API apps index" do
      expect(apps_json["_links"]["self"]["href"]).to eq "/api/apps"
    end
  end
end
