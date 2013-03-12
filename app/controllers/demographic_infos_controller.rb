class DemographicInfosController < ApplicationController

  def create
    user = Order.find(params[:order_id]).user
    if params[:demographic_info].keys[0..-2].join.length > 0
      user.create_demographic_info(params[:demographic_info])
    end
    respond_to do |format|
      format.js { render nothing: true, status: :ok }
    end
  end
end
