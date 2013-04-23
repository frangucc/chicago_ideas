require 'spec_helper'

describe Sponsor::SponsorUsersController do

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

    context 'params[:sponsor_user] is blank' do
      it 'returns error' do
        put :update, :format => :js, :id => @user.sponsor_user.id
        response.response_code.should == 422
      end

      it 'returns empty body' do
        put :update, :format => :js, :id => @user.sponsor_user.id
        response.content_type.should == 'text/javascript'
        JSON.parse(response.body).to_set.should == ["Eps logo can't be blank", "Logo can't be blank"].to_set
      end
    end

    context 'params[:sponsor_user] is present' do
      context 'only one logo is provided' do
        it 'returns error' do
          put :update, :format => :js, :id => @user.sponsor_user.id, :sponsor_user => { :logo => File.open('./spec/fixtures/sponsor_logo.jpg', 'r') }
          response.content_type.should == 'text/javascript'
          response.response_code.should == 422
        end

        it 'returns proper javascript error' do
          put :update, :format => :js, :id => @user.sponsor_user.id, :sponsor_user => { :logo => File.open('./spec/fixtures/sponsor_logo.jpg', 'r') }
          response.content_type.should == 'text/javascript'
          JSON.parse(response.body).should == ["Eps logo can't be blank"]
        end
      end

      context 'both logos are provided' do
        it 'sends notification email to staff' do
          SponsorsMailer.should_receive(:notify_logos_upload).and_return(double('mailer', :deliver => true))
          put :update, :format => :js, :id => @user.sponsor_user.id, :sponsor_user => { :logo     => File.open('./spec/fixtures/sponsor_logo.jpg', 'r'),
                                                                                        :eps_logo => File.open('./spec/fixtures/sponsor_eps_logo.eps', 'r') }
        end

        it 'returns ok' do
          put :update, :format => :js, :id => @user.sponsor_user.id, :sponsor_user => { :logo     => File.open('./spec/fixtures/sponsor_logo.jpg', 'r'),
                                                                                        :eps_logo => File.open('./spec/fixtures/sponsor_eps_logo.eps', 'r') }
          response.response_code.should == 200
          response.content_type.should  == 'text/javascript'
        end
      end
    end

  end

end
