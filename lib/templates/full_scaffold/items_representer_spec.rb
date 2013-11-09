require 'spec_helper'
require 'will_paginate/array'

describe API::<%= class_name.pluralize %>Representer do
  let(:<%= plural_name %>) do
    <%= plural_name %> = []
    <%= plural_name %> << create(:<%= singular_name %>, name: "srv-01")
    <%= plural_name %> << create(:<%= singular_name %>, name: "srv-02")
    <%= plural_name %>.paginate.extend(API::<%= class_name.pluralize %>Representer)
  end
  let(:<%= plural_name %>_json) { JSON.parse(<%= plural_name %>.to_json) }

  describe '#to_json' do
    it "contains <%= plural_name %> as embedded objects" do
      expect(<%= plural_name %>_json["_embedded"].keys).to include "<%= plural_name %>"
    end

    it "contains all <%= plural_name %>" do
      names = <%= plural_name %>_json["_embedded"]["<%= plural_name %>"].map{|repr| repr["name"]}
      expect(names).to include "srv-01", "srv-02"
    end

    it "exposes a link to API <%= plural_name %> index" do
      expect(<%= plural_name %>_json["_links"]["self"]["href"]).to eq "/api/<%= plural_name %>?page=1"
    end

    it "exposes a link to create action" do
      expect(<%= plural_name %>_json["_links"]["create"]["href"]).to eq "/api/<%= plural_name %>"
      expect(<%= plural_name %>_json["_links"]["create"]["method"]).to eq "POST"
    end
  end
end
