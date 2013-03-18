class BhsiApplicationsMailer < ActionMailer::Base

  default from:      "test@example.com"
  default subject:   'BHSI Application Form Submission'

  def send_form(bhsi)
    @bhsi = bhsi
    attachments[bhsi.pdf_file_name]              = open(bhsi.pdf.url).read
    attachments[bhsi.previous_budget_file_name]  = open(bhsi.previous_budget.url).read
    attachments[bhsi.press_clipping_1_file_name] = open(bhsi.press_clipping_1.url).read if bhsi.press_clipping_1.present?
    attachments[bhsi.press_clipping_2_file_name] = open(bhsi.press_clipping_2.url).read if bhsi.press_clipping_2.present?
    attachments[bhsi.press_clipping_3_file_name] = open(bhsi.press_clipping_3.url).read if bhsi.press_clipping_3.present?

    mail(to: 'leanucci@gmail.com')
  end

  def thank_you_application(bhsi)
    mail(to: bhsi.email)
  end

end
