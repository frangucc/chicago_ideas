class OrderMailer < ActionMailer::Base

  default :from    => ApplicationHelper::CIW_FORMS_EMAIL
  default :subject => "Thank you for joining CIW's Member Program"

  def thank_you_membership(order)
    @order = order
    mail(:to => @order.email) do |format|
      format.html { render }
    end
  end

end
