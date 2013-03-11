class DemographicInfosController < ApplicationController

  def create
    debugger
    respond_to do |format|
      format.js { render nothing: true, status: 200 }
    end
  end
end
