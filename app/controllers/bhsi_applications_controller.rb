class BhsiApplicationsController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def index
    redirect_to new_bhsi_application_path
  end

  def redirect
    redirect_to new_user_registration_path, :notice => 'To submit your application, please first create an account or log in.'
  end

  def new
    @meta_data = {:page_title => "Bluhm/Helfand Social Innovation Fellowship", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "Bluhm/Helfand Social Innovation Fellowship | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    #if current_user and current_user.bhsi_application.present?
    if current_user && current_user.bhsi_application.present?
      flash[:notice] = 'Thank you, your application has already been recieved.'
      redirect_to root_path
    elsif current_user
      @bhsi_application = current_user.build_bhsi_application
      @bhsi_application.build_bhsi_longtext
      @bhsi_application.email = current_user.email
    else

      @bhsi_application = BhsiApplication.new
      @bhsi_application.build_bhsi_longtext
    end
  end

  def create
    @meta_data = {:page_title => "Bluhm/Helfand Social Innovation Fellowship", :og_image => "http://www.chicagoideas.com/assets/application/affilliate_events_banner.jpg", :og_title => "Bluhm/Helfand Social Innovation Fellowship | Chicago Ideas Week", :og_type => "website", :og_desc => "Chicago Ideas Week (CIW) is about the sharing of ideas, inspiring action and igniting change to positively impact our world. People who come to CIW are artists, engineers, technologists, inventors, scientists, musicians, economists, explorers-and, well...just innately passionate."}
    if current_user && current_user.bhsi_application.blank?
      @bhsi_application = current_user.build_bhsi_application(params[:bhsi_application])

      if @bhsi_application.save
        render 'application/confirmation', :locals => {:title => "BHSI Application Confirmation", :body => "Thank you for applying to the Bluhm/Helfand Social Innovation Fellowship. BHSI semi-finalists will be announced in mid-June.", :url => "http://bit.ly/wdTJfn", :share_text => "I applied to the #BHSI Fellowship at @chicagoideas! RT to all #innovative #socent! Applications close 5/21. Apply today: http://bit.ly/wdTJfn"}

      else
        flash[:notice] = 'Please fill in all required fields!'
        @bhsi_appliction = @bhsi_application
        render :new
      end

    else
      flash[:notice] = 'Thank you, your application has already been recieved.'
      redirect_to root_path
    end

  end

end
