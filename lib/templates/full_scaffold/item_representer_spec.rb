require 'spec_helper'

describe API::<%= class_name %>Representer do
  let(:<%= singular_name %>) { create(:<%= singular_name %>, name: "<%= singular_name %>-#{Random.rand(1e4)}").extend(API::<%= class_name %>Representer) }
  let(:<%= singular_name %>_json) { JSON.parse(<%= singular_name %>.to_json) }
  let(:new_<%= singular_name %>) { <%= class_name %>.new.extend(API::<%= class_name %>Representer) }

  describe '#to_json' do
    it 'should serialize to json+hal' do
      expect(<%= singular_name %>_json.keys).to include('id', 'name', '_links')
    end

    it 'should expose timestamps' do
      expect(<%= singular_name %>_json.keys).to include('created_at', 'updated_at')
    end

    it 'should expose a link to self' do
      expect(<%= singular_name %>_json['_links']['self']['href']).to match %r{^/api/<%= plural_name %>/\d+$}
    end
  end

  describe '#from_json' do
    it 'should not allow writes to timestamps' do
      new_<%= singular_name %>.from_json({created_at: Time.now, updated_at: Time.now}.to_json)
      timestamp_values = new_<%= singular_name %>.attributes.slice('created_at', 'updated_at').values
      expect(timestamp_values).to eq [nil, nil]
    end
  end
end
