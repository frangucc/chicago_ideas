require 'spec_helper'

describe MemberTypesController do

  before(:each) do
    Year.create(:id => 2013)
    Year.stub(:find).and_return(double(:year))
    TalkBrand.stub_chain(:find, :talks, :current, :order, :limit).and_return([])
  end

  describe '#index' do

    it 'should success' do
      get :index
      response.should be_success
    end

    it 'returns member types' do
      get :index
      assigns[:member_types].should == []
    end

  end

end
