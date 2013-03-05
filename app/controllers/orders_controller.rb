class OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.build_billing_address
    @order.member_type = MemberType.find(params[:member_id])
  end

  def create
    @order = Order.new(params[:order])
    @order.member_type = MemberType.find(params[:order][:member_type_id])

    if @order.process_transaction
      OrderMailer.thank_you_membership(@order).deliver
      respond_to do |format|
        format.js { render :nothing => true, :status => 200 }
      end
    else
      respond_to do |format|
        format.js { render :new, :layout => false, :status => :unprocessable_entity }
      end
    end
  end

  # thank you
  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      # format.html
      format.html
      format.pdf do
        html = render_to_string(partial: "invoice", layout: false)
        kit = PDFKit.new(html, "margin-bottom" => "0.5in", "margin-top" => "0.5in", page_size: 'A4')
        css_path =  if Rails.env == "production"
                      "#{Rails.root}/public/assets/invoice.css"
                    else
                      "#{Rails.root}/app/assets/stylesheets/invoice.css"
                    end
        kit.stylesheets << css_path
        send_data kit.to_pdf, filename: "#{@order.code}.pdf", type: 'application/pdf'
      end
    end
  end

end
