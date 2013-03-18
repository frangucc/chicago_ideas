class BhsiApplicationsMailer < ActionMailer::Base

  default from:      ApplicationHelper::CIW_BHSI_SUBM_EMAIL
  default subject:   'BHSI Application Form Submission'

  def notify_staff(bhsi)
    @bhsi = bhsi
    # attachments[bhsi.pdf_file_name]              = File.read("#{Rails.root}/tmp/pdf/#{bhsi.pdf_file_name}")
    # attachments[bhsi.previous_budget_file_name]  = open(bhsi.previous_budget.url).read
    # attachments[bhsi.press_clipping_1_file_name] = open(bhsi.press_clipping_1.url).read if bhsi.press_clipping_1.present?
    # attachments[bhsi.press_clipping_2_file_name] = open(bhsi.press_clipping_2.url).read if bhsi.press_clipping_2.present?
    # attachments[bhsi.press_clipping_3_file_name] = open(bhsi.press_clipping_3.url).read if bhsi.press_clipping_3.present?

    mail(to: ApplicationHelper::BHSI_RECIPIENTS)
  end

  def notify_applicant(bhsi)
    mail(to: bhsi.email)
  end

end
