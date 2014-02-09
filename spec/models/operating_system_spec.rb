require 'spec_helper'

describe OperatingSystem do
  it { should be_versioned }

  it "can have ancestries" do
    linux  = OperatingSystem.create!(name: "Linux")
    debian = OperatingSystem.create!(name: "Debian")
    debian.parent.should be_nil
    debian.update_attribute(:parent, linux)
    debian.reload.parent.should == linux
    linux.reload.children.should == [debian]
  end
end
