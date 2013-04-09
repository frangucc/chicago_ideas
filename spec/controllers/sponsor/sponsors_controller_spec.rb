require 'spec_helper'

describe Sponsor::SponsorsController do

  before do
    Year.create(:id => 2013)
    Year.stub(:find).and_return(double(:year))
    TalkBrand.stub_chain(:find, :talks, :current, :order, :limit).and_return([])
    @user = FactoryGirl.create(:user, :is_sponsor => true, :sponsor => FactoryGirl.create(:sponsor))
    sign_in @user
  end

  after do
    sign_out @user
  end

  describe '#update' do

    context 'params[:sponsor] is blank' do
      context 'sponsor is active' do
        before do
          Sponsor.any_instance.stub(:active?).and_return(true)
          Sponsor.any_instance.stub(:unlock!)
        end

        it 'returns success' do
          put 'update', :format => :js, :id => @user.sponsor.id
          response.response_code.should == 200
        end

        it 'returns empty body' do
          put 'update', :format => :js, :id => @user.sponsor.id
          response.content_type.should == "text/javascript"
          response.body.should == " "
        end
      end

      context 'sponsor is inactive' do
        before do
          Sponsor.any_instance.stub(:active?).and_return(false)
          Sponsor.any_instance.stub(:unlock!)
        end

        it 'returns error' do
          put 'update', :format => :js, :id => @user.sponsor.id
          response.response_code.should == 422
        end

        it 'returns proper javascript error' do
          put 'update', :format => :js, :id => @user.sponsor.id
          response.content_type.should == "text/javascript"
          JSON.parse(response.body).should == ["Both logos should be provided."]
        end
      end
    end

    context 'params[:sponsor] is present' do
      context 'only valid sponsor logo is provided' do
        it 'returns error' do
          put 'update', :format => :js, :id => @user.sponsor.id, :sponsor => { :logo => File.open('./spec/fixtures/sponsor_logo.jpg', 'r') }
          response.response_code.should == 422
        end

        it 'returns proper javascript error' do
          put 'update', :format => :js, :id => @user.sponsor.id, :sponsor => { :logo => File.open('./spec/fixtures/sponsor_logo.jpg', 'r') }
          response.content_type.should == "text/javascript"
          JSON.parse(response.body).should == ["Both logos should be provided."]
        end
      end

      context 'both logos provided with invalid dimensions' do
        it 'returns error' do
          put 'update', :format => :js, :id => @user.sponsor.id, :sponsor => { :logo     => File.open('./spec/fixtures/sponsor_inv_logo.jpg', 'r'),
                                                                               :eps_logo => File.open('./spec/fixtures/sponsor_inv_logo.jpg', 'r') }
          response.response_code.should == 422
        end

        it 'returns proper javascript error' do
          put 'update', :format => :js, :id => @user.sponsor.id, :sponsor => { :logo     => File.open('./spec/fixtures/sponsor_inv_logo.jpg', 'r'),
                                                                               :eps_logo => File.open('./spec/fixtures/sponsor_inv_logo.jpg', 'r') }
          response.content_type.should == "text/javascript"
          JSON.parse(response.body).should == ["Logo Image dimensions were 468x468, they must be exactly 260x260"]
        end
      end
    end

  end

end
