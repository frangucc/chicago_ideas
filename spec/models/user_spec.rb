require 'spec_helper'

describe SponsorUser do

  describe '#invitation_accepted?' do

    let(:sponsor_user) { FactoryGirl.create(:user, :is_sponsor => true) }

    context 'invitation not accepted' do
      it 'returns false' do
        sponsor_user.invitation_accepted?.should be_false
      end
    end

    context 'invitation accepted' do
      it 'returns true' do
        sponsor_user.update_attribute(:invitation_accepted_at, Time.current)
        sponsor_user.invitation_accepted?.should be_true
      end
    end

  end

end
