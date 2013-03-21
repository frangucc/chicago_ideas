class BhsiApplicationsMailer < ActionMailer::Base

  default from:      ApplicationHelper::CIW_BHSI_SUBM_EMAIL
  default subject:   'BHSI Application Form Submission'

  def notify_staff(bhsi)
    @bhsi = bhsi
    attachments[bhsi.pdf_file_name] = File.read("/tmp/#{ @bhsi.pdf_file_name }")

    mail(to: ApplicationHelper::BHSI_RECIPIENTS, cco: (Rails.env.production? ? ApplicationHelper::BHSI_CCO : nil)) do |format|
      format.html
    end
  end

  def notify_applicant(bhsi)
    attachments[bhsi.pdf_file_name] = File.read("/tmp/#{ bhsi.pdf_file_name }")
    mail(to: bhsi.email)
  end

end
