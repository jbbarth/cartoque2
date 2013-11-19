require 'spec_helper'

describe User do
  it { should be_versioned }

  it "should not record version for internal fields changes", versioning: true do
    user = create(:user)
    expect do
      user.update_attributes(last_sign_in_at: Time.now,
                              current_sign_in_at: Time.now,
                              sign_in_count: 745)
    end.not_to change(PaperTrail::Version, :count)
  end

  describe "#seen_on" do
    it "shows the last day between last sign in and current sign in" do
      user = User.new(last_sign_in_at: DateTime.parse("31/03/2013 10:00"),
                      current_sign_in_at: DateTime.parse("05/04/2013 15:00"))
      user.seen_on.should == Date.parse("05/04/2013")
    end

    it "doesn't break on empty dates" do
      user = User.new(last_sign_in_at: nil,
                      current_sign_in_at: nil)
      user.seen_on.should == ""
    end
  end
end
