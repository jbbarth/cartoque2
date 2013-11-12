require 'spec_helper'
require 'will_paginate/array'

describe API::HistoryRepresenter, versioning: true do
  let(:server) do
    server = Server.create!(name: "server-01")
    server.update_attribute(:name, "server-001")
    server.update_attribute(:name, "server-001-primary")
    server
  end
  let(:versions) { server.versions.paginate(page: 1, per_page: 2) }
  let(:history) { History.new(versions, server)
                         .extend(API::HistoryRepresenter) }
  let(:history_json) { JSON.parse(history.to_json) }

  describe '#to_json' do
    it "contains versions as embedded objects" do
      expect(history_json["_embedded"].keys).to include "versions"
    end

    it "contains a count of all available versions" do
      expect(history_json["total_entries"]).to eq 3
    end

    it "contains a paginated list of versions" do
      expect(history_json["_embedded"]["versions"].count).to eq 2 #= per_page
    end

    it "exposes a link to self page" do
      expect(history_json["_links"]["self"]["href"]).to eq "/api/history?item_id=#{server.id}&item_type=Server&page=1"
    end
  end
end
