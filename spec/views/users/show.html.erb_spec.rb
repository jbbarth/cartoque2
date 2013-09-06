require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User, email: "bob@example.net"))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/bob@example.net/)
  end
end
