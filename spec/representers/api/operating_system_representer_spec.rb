require 'spec_helper'

describe API::OperatingSystemRepresenter do
  let(:operating_system) { create(:operating_system, name: "operating_system-#{Random.rand(1e4)}").extend(API::OperatingSystemRepresenter) }
  let(:operating_system_json) { JSON.parse(operating_system.to_json) }
  let(:new_operating_system) { OperatingSystem.new.extend(API::OperatingSystemRepresenter) }

  describe '#to_json' do
    it 'should serialize to json+hal' do
      expect(operating_system_json.keys).to include('id', 'name', '_links')
    end

    it 'should expose timestamps' do
      expect(operating_system_json.keys).to include('created_at', 'updated_at')
    end

    it 'should expose a link to self' do
      expect(operating_system_json['_links']['self']['href']).to match %r{^/api/operating_systems/\d+$}
    end
  end

  describe '#from_json' do
    it 'should not allow writes to timestamps' do
      new_operating_system.from_json({created_at: Time.now, updated_at: Time.now}.to_json)
      timestamp_values = new_operating_system.attributes.slice('created_at', 'updated_at').values
      expect(timestamp_values).to eq [nil, nil]
    end
  end
end
