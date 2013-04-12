require 'spec_helper'

describe Sponsor do

  describe '#logos_uploaded?' do

    let(:sponsor) { FactoryGirl.create(:sponsor, :eps_logo_file_name => 'eps_logo.png', :logo_file_name => 'logo.png') }

    context 'has no eps logo file name' do
      it 'returns false' do
        sponsor.eps_logo_file_name = nil
        sponsor.logos_uploaded?.should be_false
      end
    end

    context 'has no logo file name' do
      it 'returns false' do
        sponsor.logo_file_name = nil
        sponsor.logos_uploaded?.should be_false
      end
    end

    context 'has all file names' do
      it 'returns true' do
        sponsor.logos_uploaded?.should be_true
      end
    end

  end

  describe '#unlock!' do

    let(:sponsor) { FactoryGirl.create(:sponsor, :locked => true) }

    context 'inlogos_uploaded? and locked' do
      it 'unlocks the sponsor' do
        sponsor.stub(:logos_uploaded?).and_return(false)
        sponsor.unlock!
        sponsor.reload.locked?.should be_false
      end
    end

    context 'logos_uploaded? and locked' do
      it 'does not unlock the sponsor' do
        sponsor.stub(:logos_uploaded?).and_return(true)
        sponsor.unlock!
        sponsor.reload.locked?.should be_true
      end
    end

    context 'logos_uploaded? and unlocked' do
      it 'does not unlock the sponsor' do
        sponsor.update_attributes(:locked => false)
        sponsor.stub(:logos_uploaded?).and_return(true)
        sponsor.unlock!
        sponsor.reload.locked?.should be_false
      end
    end

    context 'inlogos_uploaded? and unlocked' do
      it 'does not unlock the sponsor' do
        sponsor.update_attributes(:locked => false)
        sponsor.stub(:logos_uploaded?).and_return(false)
        sponsor.unlock!
        sponsor.reload.locked?.should be_false
      end
    end

  end

end
