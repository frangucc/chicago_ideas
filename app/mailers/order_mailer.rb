class OrderMailer < ActionMailer::Base
  include PdfCreator

  def thank_you_membership(order)
    @order = order
    pdf_file = create_pdf(@order, 'orders/_invoice.pdf.haml', @order.code)
    attachments["invoice-#{@order.code}.pdf"] = File.read("#{Rails.root}/tmp/invoice-#{@order.code}.pdf")
    mail(:from => "'CIW Receipt of Purchase' <#{ApplicationHelper::CIW_FORMS_EMAIL}>",
         :to => @order.user.email,
         :subject => "Thank you for joining CIW's Member Program") do |format|
      format.html { render }
    end
  end

  def notify_member_purchase(order)
    @member = order.user.member
    mail(:from => ApplicationHelper::CIW_FORMS_EMAIL,
         :to => ApplicationHelper::MEMBER_PURCHASE_RECIPIENTS,
         :subject => "Someone just purchased a membership!")
  end

end
