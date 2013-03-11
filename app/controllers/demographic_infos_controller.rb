class DemographicInfosController < ApplicationController

  def create
    respond_to do |format|
      format.js { render nothing: true, status: :ok }
    end
  end
end
