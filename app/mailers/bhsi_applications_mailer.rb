class BhsiApplicationsMailer < ActionMailer::Base

  default from:      ApplicationHelper::CIW_BHSI_SUBM_EMAIL
  default subject:   'BHSI Application Form Submission'

  def notify_staff(bhsi)
    @bhsi = bhsi
    attachments[bhsi.pdf_file_name] = File.read("/tmp/#{ @bhsi.pdf_file_name }")

    attachments[bhsi.previous_budget_file_name]       = File.read(bhsi.previous_budget.path)        if bhsi.previous_budget.present?
    attachments[bhsi.current_budget_file_name]        = File.read(bhsi.current_budget.path)         if bhsi.current_budget.present?
    attachments[bhsi.venture_standard_deck_file_name] = File.read(bhsi.venture_standard_deck.path)  if bhsi.venture_standard_deck.present?
    attachments[bhsi.press_clipping_1_file_name]      = File.read(bhsi.press_clipping_1.path)       if bhsi.press_clipping_1.present?
    attachments[bhsi.press_clipping_2_file_name]      = File.read(bhsi.press_clipping_2.path)       if bhsi.press_clipping_2.present?
    attachments[bhsi.press_clipping_3_file_name]      = File.read(bhsi.press_clipping_3.path)       if bhsi.press_clipping_3.present?

    mail(to: ApplicationHelper::BHSI_RECIPIENTS) do |format|
      format.text { render 'notify_staff'}
    end
  end

  def notify_applicant(bhsi)
    attachments[bhsi.pdf_file_name] = File.read("/tmp/#{ bhsi.pdf_file_name }")
    mail(to: bhsi.email)
  end

end
