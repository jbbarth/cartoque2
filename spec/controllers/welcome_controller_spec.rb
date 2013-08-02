require 'spec_helper'

describe WelcomeController do
  # Fake devise login
  login_user

  it "gets index" do
    get :index
    assert_response :success
  end
end
