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

  describe '#activate!' do

    let(:sponsor) { FactoryGirl.create(:sponsor, :locked => true) }

    it 'activates the sponsor' do
      sponsor.activate!
      sponsor.reload.locked?.should be_false
    end

  end

end
