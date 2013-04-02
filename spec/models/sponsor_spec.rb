require 'spec_helper'

describe Sponsor do

  describe '#active?' do

    let(:sponsor) { FactoryGirl.create(:sponsor, :eps_logo_file_name => 'eps_logo.png', :logo_file_name => 'logo.png', :sponsor_agreement_file_name => 'agreement.txt') }

    context 'has no eps logo file name' do
      it 'returns false' do
        sponsor.eps_logo_file_name = nil
        sponsor.active?.should be_false
      end
    end

    context 'has no logo file name' do
      it 'returns false' do
        sponsor.logo_file_name = nil
        sponsor.active?.should be_false
      end
    end

    context 'has no agreement file name' do
      it 'returns false' do
        sponsor.sponsor_agreement_file_name = nil
        sponsor.active?.should be_false
      end
    end

    context 'has all file names' do
      it 'returns true' do
        sponsor.active?.should be_true
      end
    end

  end

end
