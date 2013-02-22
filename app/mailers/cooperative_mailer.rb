class CooperativeMailer < ActionMailer::Base

  default :from    => 'kelly@chicagoideas.com'
  default :subject => "Cooperative Application Form Submission"

  def send_form(cooperative_application)
    #attachments[filename] = File.read("#{Rails.root}/tmp/#{filename}");
    @cooperative_application = cooperative_application
    mail(:to => 'kelly@chicagoideas.com')
  end

end
