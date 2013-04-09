require 'spec_helper'

describe Sponsor do

  describe 'Validations' do

    describe '#validate_logo_dimensions' do
      context 'valid logo dimensions' do
        it 'validates' do
          sponsor = FactoryGirl.build(:sponsor, :logo => File.open('./spec/fixtures/sponsor_logo.jpg', 'r'))
          sponsor.errors[:logo].should be_empty
        end
      end

      context 'invalid logo dimensions' do
        it 'returns error' do
          sponsor = FactoryGirl.build(:sponsor, :logo => File.open('./spec/fixtures/sponsor_inv_logo.jpg', 'r'))
          sponsor.errors[:logo].join.should match(/Image dimensions were 468x468, they must be exactly 260x260/)
        end
      end
    end

    describe '#validate_eps_logo_dimensions' do
      context 'valid eps_logo dimensions' do
        it 'validates' do
          sponsor = FactoryGirl.build(:sponsor, :eps_logo => File.open('./spec/fixtures/sponsor_eps_logo.png', 'r'))
          sponsor.errors[:eps_logo].should be_empty
        end
      end

      context 'invalid eps_logo dimensions' do
        it 'returns error' do
          sponsor = FactoryGirl.build(:sponsor, :eps_logo => File.open('./spec/fixtures/sponsor_inv_logo.jpg', 'r'))
          sponsor.errors[:eps_logo].join.should match(/Image dimensions were 468x468, they must be exactly 271x211/)
        end
      end
    end

  end

  describe '#active?' do

    let(:sponsor) { FactoryGirl.create(:sponsor, :eps_logo_file_name => 'eps_logo.png', :logo_file_name => 'logo.png') }

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

    context 'has all file names' do
      it 'returns true' do
        sponsor.active?.should be_true
      end
    end

  end

  describe '#unlock!' do

    let(:sponsor) { FactoryGirl.create(:sponsor, :locked => true) }

    context 'inactive and locked' do
      it 'unlocks the sponsor' do
        sponsor.stub(:active?).and_return(false)
        sponsor.unlock!
        sponsor.reload.locked?.should be_false
      end
    end

    context 'active and locked' do
      it 'does not unlock the sponsor' do
        sponsor.stub(:active?).and_return(true)
        sponsor.unlock!
        sponsor.reload.locked?.should be_true
      end
    end

    context 'active and unlocked' do
      it 'does not unlock the sponsor' do
        sponsor.update_attributes(:locked => false)
        sponsor.stub(:active?).and_return(true)
        sponsor.unlock!
        sponsor.reload.locked?.should be_false
      end
    end

    context 'inactive and unlocked' do
      it 'does not unlock the sponsor' do
        sponsor.update_attributes(:locked => false)
        sponsor.stub(:active?).and_return(false)
        sponsor.unlock!
        sponsor.reload.locked?.should be_false
      end
    end

  end

end
