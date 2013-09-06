require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User, email: "bob@example.net"),
      stub_model(User, email: "john@example.net")
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: /example.net/, count: 2
  end
end
