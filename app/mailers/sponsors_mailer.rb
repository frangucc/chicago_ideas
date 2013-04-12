class SponsorsMailer < ActionMailer::Base

  default :from => ApplicationHelper::CIW_FORMS_EMAIL
  default :to   => ApplicationHelper::CIW_SAM_EMAIL

  def notify_logos_upload(sponsor)
    @sponsor = sponsor
    mail(:subject => 'New logos uploaded for sponsor.')
  end

end
