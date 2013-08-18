require 'spec_helper'

describe API::ServersRepresenter do
  let(:servers) do
    servers = []
    servers << create(:server, name: "srv-01")
    servers << create(:server, name: "srv-02")
    servers.extend(API::ServersRepresenter)
  end
  let(:servers_json) { JSON.parse(servers.to_json) }

  describe '#to_json' do
    it "contains servers as embedded objects" do
      expect(servers_json["_embedded"].keys).to include "servers"
    end

    it "contains all servers" do
      names = servers_json["_embedded"]["servers"].map{|repr| repr["name"]}
      expect(names).to include "srv-01", "srv-02"
    end

    it "exposes a link to API servers index" do
      expect(servers_json["_links"]["self"]["href"]).to eq "/api/servers"
    end
  end
end
