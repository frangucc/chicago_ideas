require 'spec_helper'

describe CooperativeController do

  # NOTE: commented out, since all the logic for submitting coops was commented.
  #
  #before(:each) do
    #Year.create(:id => 2013)
    #Year.stub(:find).and_return(double(:year))
    #TalkBrand.stub_chain(:find, :talks, :current, :order, :limit).and_return([])
  #end

  #describe '#application' do

    #it 'should success' do
      #get :application
      #response.should be_success
    #end

    #it 'builds new Cooperative Application instance' do
      #get :application
      #assigns[:resource].should be_an_instance_of CooperativeApplication
    #end

  #end

  #describe '#create' do

    #context 'when valid params' do
      #it 'sends mailers and success' do
        #CooperativeMailer.should_receive(:send_form).and_return(double('mailer', :deliver => true))
        #CooperativeMailer.should_receive(:thank_you_application).and_return(double('mailer', :deliver => true))
        #post :create, :format => 'js', :cooperative_application => { :name            => 'John',
                                                                     #:last_name       => 'Doe',
                                                                     #:email           => 'john@doe.com',
                                                                     #:organization    => 'Organization',
                                                                     #:phone           => '123-4567',
                                                                     #:org_mission     => 'Mission',
                                                                     #:org_website     => 'www.website.com',
                                                                     #:org_twitter     => 'twitter',
                                                                     #:reason          => 'Reason',
                                                                     #:worked_on       => 'volunteerism',
                                                                     #:part_meaningful => 'meaningful',
                                                                     #:ins_failure     => 'Inspiring Failure',
                                                                     #:neighborhood    => 'Neighborhood',
                                                                     #:assisted_area   => 'Assisted Area',
                                                                     #:recommend       => 'Recommendations' }
        #response.should be_success
      #end
    #end

    #context 'when invalid params' do
      #it 'returns error' do
        #post :create, :format => 'js'
        #response.status.should == 422
      #end
    #end

  #end

end
