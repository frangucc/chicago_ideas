class DemographicInfosController < ApplicationController

  def create
    user = Order.find(params[:order_id]).user
    user.create_demographic_info(params[:demographic_info])
    respond_to do |format|
      format.js { render nothing: true, status: :ok }
    end
  end
end
