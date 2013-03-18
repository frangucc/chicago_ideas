require 'spec_helper'

describe BhsiApplicationsController do


  # NOTE: commented out, since all the logic was moved away from the controller
  # before(:each) do
  #   Year.stub(:find).and_return(double(:year, id: 2013))
  #   TalkBrand.stub_chain(:find, :talks, :current, :order, :limit).and_return([])
  # end

  # describe '#index' do

  #   before(:each) do
  #     get :index
  #   end

  #   it 'should redirect' do
  #     response.should be_redirect
  #   end

  #   it 'redirects to new bhsi application url' do
  #     assert_redirected_to new_bhsi_application_path
  #   end

  # end

  # describe '#redirect' do

  #   before(:each) do
  #     get :redirect
  #   end

  #   it 'should redirect' do
  #     response.should be_redirect
  #     flash[:notice].should match(/To submit your application, please first create an account or log in\./)
  #   end

  #   it 'redirects to new bhsi application url' do
  #     assert_redirected_to new_user_registration_path
  #   end

  # end

  # describe '#create' do

  #   context 'when not logged in' do
  #     it 'redirects to sign in page' do
  #       post :create
  #       response.should be_redirect
  #       flash[:alert].should match(/You need to sign in or sign up before continuing\./)
  #       assert_redirected_to new_user_session_path
  #     end
  #   end

  #   context 'when logged in' do

  #     before(:each) do
  #       @user = FactoryGirl.create(:user)
  #       sign_in @user
  #     end

  #     after(:each) do
  #       sign_out @user
  #     end

  #     context 'when current user has not applied to bhsi' do

  #       context 'when all params are valid' do
  #         it 'renders thank you page and sends confirmation emails' do
  #           BhsiApplication.any_instance.should_receive(:save).and_return(true)

  #           # TODO: PDF generation should be mocked.
  #           post :create

  #           # mock_send_form = double('mock_send_form').as_null_object
  #           # BhsiApplicationsMailer.should_receive(:delay).and_return(mock_send_form)
  #           # mock_send_form.should_receive(:send_form).and_return(double('mailer', :deliver => true))
  #           #
  #           # mock_thank = double('mock_thank').as_null_object
  #           # BhsiApplicationsMailer.should_receive(:delay).and_return(mock_thank)
  #           # mock_thank.should_receive(:thank_you_application).and_return(double('mailer', :deliver => true))

  #           response.should be_success
  #         end
  #       end

  #       context 'when invalid params' do
  #         it 'renders an error' do
  #           # TODO: PDF generation should be mocked.
  #           post :create
  #           response.should be_success
  #           flash[:notice].should match(/Please fill in all required fields\!/)
  #         end
  #       end
  #     end

  #     context 'when current user has already applied to bhsi' do
  #       it 'redirects to root path' do
  #         User.any_instance.stub_chain(:bhsi_application, :blank?).and_return(false)
  #         post :create
  #         response.should be_redirect
  #         flash[:notice].should match(/Thank you, your application has already been recieved\./)
  #         assert_redirected_to root_path
  #       end
  #     end

  #   end

  # end

end
