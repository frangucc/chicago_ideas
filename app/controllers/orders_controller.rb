class OrdersController < ApplicationController

  def new
    @address  = Address.new
    @member   = Member.new
    @order    = Order.new
    @order.build_billing_address
    @order.build_user
    @order.member_type = MemberType.find(params[:member_id])
    @demographic_info = DemographicInfo.new
  end

  def create
    address_params = params[:order].delete "address"
    member_params  = params[:order].delete "member"

    @order    = Order.new(params[:order])
    @address  = Address.new(address_params)
    @member   = Member.new(member_params)

    @order.user.address   = @address
    @order.user.member    = @member
    @order.user.is_member = true
    @order.user.password  = SecureRandom.hex(5).upcase
    @order.user.name      = "#{@member.first_name} #{@member.last_name}"

    @member.year = Year.last

    @order.member_type = @member.member_type = MemberType.find(params[:order][:member_type_id])
    @demographic_info = DemographicInfo.new

    if @order.process_transaction
      OrderMailer.delay.thank_you_membership(@order)
      respond_to do |format|
        format.js { render :text => "#{@order.id}", :status => 200 }
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
      format.html
    end
  end

  private
  def use_https?
    false
  end

end
