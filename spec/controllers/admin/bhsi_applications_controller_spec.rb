require 'spec_helper'

describe Admin::BhsiApplicationsController do

  before(:each) do
    Year.create(:id => 2013)
    Year.stub(:find).and_return(double(:year))
    TalkBrand.stub_chain(:find, :talks, :current, :order, :limit).and_return([])
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  after(:each) do
    sign_out @user
  end

  describe '#index' do

    ['html', 'xls'].each do |format|
      context "when format is #{format}" do
        it 'should redirect' do
          get :index, :format => format
          response.should be_redirect
        end
      end
    end

  end

end
