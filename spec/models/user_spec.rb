require 'spec_helper'

describe User do
  it { should be_versioned }

  it "should not generate a new version when just changing 'last sign in' informations" do
    begin
      PaperTrail.enabled = true
      user = create(:user)
      expect do
        user.update_attributes(last_sign_in_at: Time.now,
                               current_sign_in_at: Time.now,
                               sign_in_count: 745)
      end.not_to change(PaperTrail::Version, :count)
    ensure
      PaperTrail.enabled = false
    end
  end
end
