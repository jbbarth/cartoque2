require 'spec_helper'

describe API::LocationRepresenter do
  let(:location) { create(:location, name: "location-#{Random.rand(1e4)}").extend(API::LocationRepresenter) }
  let(:location_json) { JSON.parse(location.to_json) }
  let(:new_location) { Location.new.extend(API::LocationRepresenter) }

  describe '#to_json' do
    it 'should serialize to json+hal' do
      expect(location_json.keys).to include('id', 'name', '_links')
    end

    it 'should expose timestamps' do
      expect(location_json.keys).to include('created_at', 'updated_at')
    end

    it 'should expose a link to self' do
      expect(location_json['_links']['self']['href']).to match %r{^/api/locations/\d+$}
    end
  end

  describe '#from_json' do
    it 'should not allow writes to timestamps' do
      new_location.from_json({created_at: Time.now, updated_at: Time.now}.to_json)
      timestamp_values = new_location.attributes.slice('created_at', 'updated_at').values
      expect(timestamp_values).to eq [nil, nil]
    end
  end
end
