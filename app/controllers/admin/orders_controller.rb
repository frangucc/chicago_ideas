class Admin::OrdersController < Admin::AdminController
  def index
    @orders = Order.includes(:member_type, :user).order('created_at DESC').page(params[:page])
  end
end
