require 'spec_helper'

describe "servers/index" do
  before(:each) do
    view.stub(:will_paginate) #avoid errors with will_paginate
    assign(:servers, [
      stub_model(Server,
        name: "Name"
      ),
      stub_model(Server,
        name: "Name"
      )
    ])
  end

  it "renders a list of servers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
