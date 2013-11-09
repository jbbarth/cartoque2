require 'spec_helper'
require 'will_paginate/array'

describe API::UsersRepresenter do
  let(:users) do
    users = []
    users << create(:user, email: "user-01@example.net")
    users << create(:user, email: "user-02@example.net")
    users.paginate.extend(API::UsersRepresenter)
  end
  let(:users_json) { JSON.parse(users.to_json) }

  describe '#to_json' do
    it "contains users as embedded objects" do
      expect(users_json["_embedded"].keys).to include "users"
    end

    it "contains all users" do
      emails = users_json["_embedded"]["users"].map{|repr| repr["email"]}
      expect(emails).to include "user-01@example.net", "user-02@example.net"
    end

    it "exposes a link to API users index" do
      expect(users_json["_links"]["self"]["href"]).to eq "/api/users?page=1"
    end

    it "exposes a link to create action" do
      expect(users_json["_links"]["create"]["href"]).to eq "/api/users"
      expect(users_json["_links"]["create"]["method"]).to eq "POST"
    end
  end
end
