require 'spec_helper'

describe API::ServerRepresenter do
  let(:server) { create(:server, name: "server-#{Random.rand(1e4)}").extend(API::ServerRepresenter) }
  let(:server_json) { JSON.parse(server.to_json) }
  let(:new_server) { Server.new.extend(API::ServerRepresenter) }

  describe '#to_json' do
    it 'should serialize to json+hal' do
      expect(server_json.keys).to include('id', 'name', '_links')
    end

    it 'should expose timestamps' do
      expect(server_json.keys).to include('created_at', 'updated_at')
    end

    it 'should expose a link to self' do
      expect(server_json['_links']['self']['href']).to match %r{^/servers/\d+$}
    end
  end

  describe '#from_json' do
    it 'should not allow writes to timestamps' do
      new_server.from_json({created_at: Time.now, updated_at: Time.now}.to_json)
      timestamp_values = new_server.attributes.slice('created_at', 'updated_at').values
      expect(timestamp_values).to eq [nil, nil]
    end
  end
end
