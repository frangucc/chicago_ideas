require 'spec_helper'

describe Sponsor::DashboardController do

  before do
    Year.create(:id => 2013)
    Year.stub(:find).and_return(double(:year))
    TalkBrand.stub_chain(:find, :talks, :current, :order, :limit).and_return([])
    @user = FactoryGirl.create(:user, :is_sponsor =>true)
    sign_in @user
  end

  after do
    sign_out @user
  end

  describe '#index' do

    it 'should success' do
      get 'index'
      response.should be_success
    end

  end

end
