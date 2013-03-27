class OrderMailer < ActionMailer::Base
  include PdfCreator

  default :from    => "'CIW Receipt of Purchase' <#{ApplicationHelper::CIW_FORMS_EMAIL}>"
  default :subject => "Thank you for joining CIW's Member Program"

  def thank_you_membership(order)
    @order = order
    pdf_file = create_pdf(@order, 'orders/_invoice.pdf.haml', @order.code)
    attachments["invoice-#{@order.code}.pdf"] = File.read("#{Rails.root}/tmp/invoice-#{@order.code}.pdf")
    mail(:to => @order.user.email) do |format|
      format.html { render }
    end
  end

end
