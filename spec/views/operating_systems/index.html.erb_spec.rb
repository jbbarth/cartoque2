require 'spec_helper'

describe "operating_systems/index" do
  before(:each) do
    view.stub(:will_paginate) #avoid errors with will_paginate
    assign(:operating_systems, [
      stub_model(OperatingSystem,
        :name => "Name",
        :codename => "Codename"
      ),
      stub_model(OperatingSystem,
        :name => "Name",
        :codename => "Codename"
      )
    ])
  end

  it "renders a list of operating_systems" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Codename".to_s, :count => 2
  end
end
