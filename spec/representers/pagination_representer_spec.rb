require "spec_helper"
require "will_paginate/array"

module PaginatedArrayRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia
  include PaginationRepresenter

  collection :items

  def items
    self
  end

  def page_url(*args)
    args
  end
end

describe PaginationRepresenter do
  def augmented(ary)
    JSON.parse(ary.extend(PaginatedArrayRepresenter).to_json)
  end

  it "limits view to N items" do
    json = augmented([*1..100].paginate)
    expect(json["items"].count).to eq 30
  end

  it "adds a count for total number of entries" do
    json = augmented([*1..100].paginate)
    expect(json["total_entries"]).to eq 100
  end

  it "adds a link to next and previous pages" do
    json = augmented([*1..100].paginate(page: 2, per_page: 3))
    expect(json["_links"].keys).to include *%w(self next previous)
  end

  it "doesn't add a link to previous page on first page" do
    json = augmented([*1..100].paginate(page: 1, per_page: 3))
    expect(json["_links"].keys).to_not include "previous"
  end

  it "doesn't add a link to next page on last page" do
    json = augmented([*1..100].paginate(page: 2, per_page: 50))
    expect(json["_links"].keys).to_not include "next"
  end

  it "forces to override the page_url() method" do
    ary = [*1..100].paginate.extend(PaginationRepresenter)
    expect do
      ary.to_json
    end.to raise_error RuntimeError, "Implement me!"
  end
end
