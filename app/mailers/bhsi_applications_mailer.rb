class BhsiApplicationsMailer < ActionMailer::Base

  default :from    => ApplicationHelper::CIW_BHSI_SUBM_EMAIL
  default :subject => 'BHSI Application Form Submission'

  def send_form(bhsi_application, filename)
    attachments[filename] = File.read(bhsi_application.pdf)
    mail(:to => "#{ApplicationHelper::CIW_JESSICA_EMAIL}, #{ApplicationHelper::CIW_COREY_EMAIL}, #{ApplicationHelper::DAVID_EMAIL}")
  end

  def thank_you_application(bhsi_application)
    mail(:to => bhsi_application.email)
  end

end
