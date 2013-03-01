class Admin::CooperativeApplicationsController < Admin::AdminController
  def index
    @cooperative_applications = CooperativeApplication.search_sort_paginate(params)
  end

  def show
    @section_title = 'Detail'
    @cooperative_application = CooperativeApplication.find(params[:id])
    respond_to do |format|

      format.pdf {

        # if !@cooperative_application.pdf.exists?
          pdf = doc_raptor_send({:document_type => "pdf".to_sym})
          friendlyName = "CPA_#{@cooperative_application.name}.pdf"
          friendlyName = friendlyName.gsub(" ", "")
          friendlyName = friendlyName.gsub("/", "_")
          File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
          @cooperative_application.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");
          @cooperative_application.save!({:validate => false})
          send_data pdf, :filename => friendlyName, :type => "pdf"
        # else
          # redirect_to @cooperative_application.pdf.url
        # end

      }
      format.html {
        render
      }
      format.xls
    end
  end

end
