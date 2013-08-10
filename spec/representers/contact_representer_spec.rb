require 'spec_helper'

describe ContactRepresenter do
  let(:contact) { create(:contact, name: "John Doe ##{Random.rand(1e4)}").extend(ContactRepresenter) }
  let(:contact_json) { JSON.parse(contact.to_json) }
  let(:new_contact) { Contact.new.extend(ContactRepresenter) }

  describe '#to_json' do
    it 'should serialize to json+hal' do
      expect(contact_json.keys).to include('id', 'name', '_links')
    end

    it 'should expose timestamps' do
      expect(contact_json.keys).to include('created_at', 'updated_at')
    end

    it 'should expose a link to self' do
      expect(contact_json['_links']['self']['href']).to match %r{^/contacts/\d+$}
    end
  end

  describe '#from_json' do
    it 'should not allow writes to timestamps' do
      new_contact.from_json({created_at: Time.now, updated_at: Time.now}.to_json)
      timestamp_values = new_contact.attributes.slice('created_at', 'updated_at').values
      expect(timestamp_values).to eq [nil, nil]
    end
  end
end
