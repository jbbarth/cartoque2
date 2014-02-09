require 'spec_helper'

describe "operating_systems/new" do
  before(:each) do
    assign(:operating_system, stub_model(OperatingSystem,
      :name => "MyString",
      :codename => "MyString"
    ).as_new_record)
    assign(:operating_systems, [])
  end

  it "renders new operating_system form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", operating_systems_path, "post" do
      assert_select "input#operating_system_name[name=?]", "operating_system[name]"
      assert_select "input#operating_system_codename[name=?]", "operating_system[codename]"
    end
  end
end
