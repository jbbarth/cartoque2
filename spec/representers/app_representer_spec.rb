require 'spec_helper'

describe AppRepresenter do
  let(:app) { create(:app, name: "app-#{Random.rand(1e4)}").extend(AppRepresenter) }
  let(:app_json) { JSON.parse(app.to_json) }
  let(:new_app) { App.new.extend(AppRepresenter) }

  describe '#to_json' do
    it 'should serialize to json+hal' do
      expect(app_json.keys).to include('id', 'name', '_links')
    end

    it 'should expose timestamps' do
      expect(app_json.keys).to include('created_at', 'updated_at')
    end

    it 'should expose a link to self' do
      expect(app_json['_links']['self']['href']).to match %r{^/apps/\d+$}
    end
  end

  describe '#from_json' do
    it 'should not allow writes to timestamps' do
      new_app.from_json({created_at: Time.now, updated_at: Time.now}.to_json)
      timestamp_values = new_app.attributes.slice('created_at', 'updated_at').values
      expect(timestamp_values).to eq [nil, nil]
    end
  end
end
