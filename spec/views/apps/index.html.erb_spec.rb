require 'spec_helper'

describe "apps/index" do
  before(:each) do
    view.stub(:will_paginate) #avoid errors with will_paginate
    assign(:apps, [
      stub_model(App,
        name: "Name"
      ),
      stub_model(App,
        name: "Name"
      )
    ])
  end

  it "renders a list of apps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
