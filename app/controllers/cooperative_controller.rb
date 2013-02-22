class CooperativeController < ApplicationController
  def application
    @resource = CooperativeApplication.new
  end

  def create
    @resource = CooperativeApplication.new(params[:cooperative_application])

    #pdf = doc_raptor_send({:document_type => "pdf".to_sym})
    #friendlyName = "Cooperative_#{@resource.name}.pdf"
    #friendlyName = friendlyName.gsub(" ", "")
    #friendlyName = friendlyName.gsub("/", "_")
    #File.open("#{Rails.root}/tmp/#{friendlyName}", 'w+b') {|f| f.write(pdf) }
    #@resource.pdf = File.open("#{Rails.root}/tmp/#{friendlyName}");

    if @resource.save
      CooperativeMailer.send_form(@resource).deliver

      respond_to do |format|
        format.html { redirect_to thankyou_cooperative_index_path }
        format.js   { render :nothing => true, :status => 200 }
      end
    else
      respond_to do |format|
        format.html { render :application }
        format.js   { render :application, :layout => false, :status => :unprocessable_entity }
      end
    end
  end
end
