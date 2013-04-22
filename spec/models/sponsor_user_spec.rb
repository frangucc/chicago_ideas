require 'spec_helper'

describe SponsorUser do

  let(:sponsor_user) { FactoryGirl.create(:sponsor_user) }

  describe 'Validations' do

    context 'sponsor user has no eps_logo' do
      it 'should be invalid' do
        sponsor_user.update_attributes(:newsletters_subscription => true)
        sponsor_user.should be_invalid
        sponsor_user.errors[:eps_logo].join.should match(/can't be blank/)
      end
    end

    context 'sponsor user has no logo' do
      it 'should be invalid' do
        sponsor_user.update_attributes(:newsletters_subscription => true)
        sponsor_user.should be_invalid
        sponsor_user.errors[:logo].join.should match(/can't be blank/)
      end
    end

    context 'sponsor user uploads eps_logo with invalid content type' do
      it 'should be invalid' do
        sponsor_user.update_attributes(:eps_logo => File.open('./spec/fixtures/blank.pdf', 'r'))
        sponsor_user.should be_invalid
        sponsor_user.errors[:eps_logo_content_type].join.should match(/is invalid/)
      end
    end

    context 'sponsor user uploads logo with invalid content type' do
      it 'should be invalid' do
        sponsor_user.update_attributes(:logo => File.open('./spec/fixtures/blank.pdf', 'r'))
        sponsor_user.should be_invalid
        sponsor_user.errors[:logo_content_type].join.should match(/is invalid/)
      end
    end

  end

end
