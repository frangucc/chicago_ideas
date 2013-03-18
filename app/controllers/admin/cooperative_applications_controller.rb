class Admin::CooperativeApplicationsController < Admin::AdminController
  def index
    respond_to do |format|
      format.html { @cooperative_applications = CooperativeApplication.search_sort_paginate(params) }
      format.xls { @cooperative_applications = CooperativeApplication.all }
    end
  end

  def show
    @section_title = 'Detail'
    @cooperative_application = CooperativeApplication.find(params[:id])

    respond_to do |format|
      format.pdf do
        html_file = render_to_string(:partial => 'cooperative/cooperative_application_pdf', :layout => false)
        kit = PDFKit.new(html_file, :page_size => 'Letter')
        send_data kit.to_pdf, :filename => generate_pdf_name(@cooperative_application), :type => 'application/pdf'
      end
      format.html {}
    end
  end

  private

  def generate_pdf_name(cooperative_application)
    pdf_name = "CPA_#{cooperative_application.name}_#{cooperative_application.last_name}.pdf"
    pdf_name.gsub!(' ', '')
    pdf_name.gsub!('/', '_')
    pdf_name
  end

end
