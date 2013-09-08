require 'spec_helper'

describe "contacts/index" do
  before(:each) do
    view.stub(:will_paginate) #avoid errors with will_paginate
    assign(:contacts, [
      stub_model(Contact,
        name: "Name"
      ),
      stub_model(Contact,
        name: "Name"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
