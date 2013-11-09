require 'spec_helper'
require 'will_paginate/array'

describe API::ContactsRepresenter do
  let(:contacts) do
    contacts = []
    contacts << create(:contact, name: "contact-01")
    contacts << create(:contact, name: "contact-02")
    contacts.paginate.extend(API::ContactsRepresenter)
  end
  let(:contacts_json) { JSON.parse(contacts.to_json) }

  describe '#to_json' do
    it "contains contacts as embedded objects" do
      expect(contacts_json["_embedded"].keys).to include "contacts"
    end

    it "contains all contacts" do
      names = contacts_json["_embedded"]["contacts"].map{|repr| repr["name"]}
      expect(names).to include "contact-01", "contact-02"
    end

    it "exposes a link to API contacts index" do
      expect(contacts_json["_links"]["self"]["href"]).to eq "/api/contacts?page=1"
    end

    it "exposes a link to create action" do
      expect(contacts_json["_links"]["create"]["href"]).to eq "/api/contacts"
      expect(contacts_json["_links"]["create"]["method"]).to eq "POST"
    end
  end
end
