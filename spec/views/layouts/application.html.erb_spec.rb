require 'spec_helper'

describe "layouts/application" do
  before do
    view.stub(:signed_in?, false)
  end

  it "displays notice if present" do
    flash.now[:notice] = "A warning"
    render
    assert_select "div.alert-warning", text: "A warning"
  end

  it "doesn't show notice box if no notice" do
    render
    assert_select "div.alert-warning", count: 0
  end

  it "displays alert if present" do
    flash.now[:alert] = "An alert"
    render
    assert_select "div.alert-error", text: "An alert"
  end

  it "doesn't show alert box if no alert" do
    render
    assert_select "div.alert-error", count: 0
  end

  it "doesn't show links in navbar if not logged in" do
    render
    assert_select ".navbar li a", count: 0
  end
end
