require 'spec_helper'

describe HelpController do
  # Fake devise login
  login_user

  describe "#show" do
    it "renders using the requested page through show.js.erb" do
      xhr :get, :show, page: "keyboard", format: :js
      response.should render_template("show")
    end
  end
end
