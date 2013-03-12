class Admin::OrdersController < Admin::AdminController
  def index
    @orders = Order.includes(:member_type, :user).order('created_at DESC').page(params[:page])
  end

  def show
    @order = Order.includes(:member_type, :billing_address, :user => [:member, :address] ).find_by_code!(params[:id])
  end
end
