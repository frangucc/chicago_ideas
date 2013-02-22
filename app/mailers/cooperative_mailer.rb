class CooperativeMailer < ActionMailer::Base

  default :from => "forms@chicagoideas.com"
  default :to => "kelly@chicagoideas.com"
  default :subject => "Cooperative Application Form Submission"

  def send_form
    #attachments[filename] = File.read("#{Rails.root}/tmp/#{filename}");
    mail()
  end

end
