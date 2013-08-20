require 'spec_helper'

describe API::UserRepresenter do
  let(:user) { create(:user, email: "user-#{Random.rand(1e4)}@example.net").extend(API::UserRepresenter) }
  let(:user_json) { JSON.parse(user.to_json) }
  let(:new_user) { User.new.extend(API::UserRepresenter) }

  describe '#to_json' do
    it 'should serialize to json+hal' do
      expect(user_json.keys).to include('id', 'email', '_links')
    end

    it 'should expose timestamps' do
      expect(user_json.keys).to include('created_at', 'updated_at')
    end

    it 'should expose a link to self' do
      expect(user_json['_links']['self']['href']).to match %r{^/api/users/\d+$}
    end
  end

  describe '#from_json' do
    it 'should not allow writes to timestamps' do
      new_user.from_json({created_at: Time.now, updated_at: Time.now}.to_json)
      timestamp_values = new_user.attributes.slice('created_at', 'updated_at').values
      expect(timestamp_values).to eq [nil, nil]
    end
  end
end
