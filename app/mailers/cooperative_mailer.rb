class CooperativeMailer < ActionMailer::Base

  default :from    => ApplicationHelper::CIW_KELLY_EMAIL
  default :subject => "Cooperative Application Form Submission"

  def send_form(cooperative_application)
    @cooperative_application = cooperative_application
    mail(:to => ApplicationHelper::CIW_KELLY_EMAIL)
  end

  def thank_you_application(cooperative_application)
    @cooperative_application = cooperative_application
    mail(:to => @cooperative_application.email)
  end

end
