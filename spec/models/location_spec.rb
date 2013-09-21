require 'spec_helper'

describe Location do
  it "can have ancestries" do
    datacenter = Location.create!(name: "Main DC")
    room       = Location.create!(name: "Room 1")
    room.parent.should be_nil
    room.update_attribute(:parent, datacenter)
    room.reload.parent.should == datacenter
    datacenter.reload.children.should == [room]
  end
end
