require 'spec_helper'

describe "layouts/application" do
  before do
    view.stub(:signed_in? => false)
  end

  it "displays notice if present" do
    flash.now[:notice] = "A notice"
    render
    assert_select "div.flash-notice", text: "A notice"
  end

  it "doesn't show notice box if no notice" do
    render
    assert_select "div.flash-notice", count: 0
  end

  it "displays flash if present" do
    flash.now[:error] = "An alert"
    render
    assert_select "div.flash-error", text: "An alert"
  end

  it "doesn't show flash box if no flash" do
    render
    assert_select "div.flash-error", count: 0
  end

  it "doesn't show links in navbar if not logged in" do
    render
    assert_select ".navbar li a", count: 0
  end
end
