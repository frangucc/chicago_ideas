class Admin::BhsiApplicationsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    year = params[:year] || "2013"
    lower_limit = Time.new(year)
    upper_limit = lower_limit.end_of_year
    respond_to do |format|
      @bhsi_applications = BhsiApplication.search_sort_paginate(params).where("created_at > '#{ lower_limit }' AND created_at < '#{ upper_limit }'")
      format.html {}
      format.xls  { @bhsi_applications = BhsiApplication.where("created_at > '#{ lower_limit }' AND created_at < '#{ upper_limit }'") }
    end
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

  # standard CRUD functionality exists in the base AdminController

  # the detail page for this affiliate_event_applications
  def show
    @section_title = 'Detail'
    @bhsi_application = BhsiApplication.find(params[:id])

    respond_to do |format|
      format.html
    end

  end

  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this affiliate_event_applications
  def notes
    @bhsi_application = BhsiApplication.find(params[:id])
    @notes = @bhsi_application.notes.includes(:author).search_sort_paginate(params, :parent => @bhsi_application)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

  private

  def generate_pdf_name(bhsi_application)
    pdf_name = "BHSI_Application_#{bhsi_application.first_name}_#{bhsi_application.last_name}.pdf"
    pdf_name.gsub!(' ', '')
    pdf_name.gsub!('/', '_')
    pdf_name
  end

end
