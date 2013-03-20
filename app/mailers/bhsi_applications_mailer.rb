class BhsiApplicationsMailer < ActionMailer::Base

  default from:      ApplicationHelper::CIW_BHSI_SUBM_EMAIL
  default subject:   'BHSI Application Form Submission'

  def notify_staff(bhsi)
    @bhsi = bhsi
    attachments[bhsi.pdf_file_name] = File.read("/tmp/#{ @bhsi.pdf_file_name }")

    attachments[bhsi.previous_budget_file_name]       = open(bhsi.previous_budget.url).read if bhsi.previous_budget.present?
    attachments[bhsi.current_budget_file_name]        = open(bhsi.current_budget.url).read if bhsi.current_budget.present?
    attachments[bhsi.venture_standard_deck_file_name] = open(bhsi.venture_standard_deck.url).read if bhsi.venture_standard_deck.present?
    attachments[bhsi.press_clipping_1_file_name]      = open(bhsi.press_clipping_1.url).read if bhsi.press_clipping_1.present?
    attachments[bhsi.press_clipping_2_file_name]      = open(bhsi.press_clipping_2.url).read if bhsi.press_clipping_2.present?
    attachments[bhsi.press_clipping_3_file_name]      = open(bhsi.press_clipping_3.url).read if bhsi.press_clipping_3.present?

    mail(to: ApplicationHelper::BHSI_RECIPIENTS) do |format|
      format.text { render 'notify_staff'}
    end
  end

  def notify_applicant(bhsi)
    mail(to: bhsi.email)
  end

end
