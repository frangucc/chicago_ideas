class Sponsor::SponsorsController < Sponsor::BaseController

  def edit
    @sponsor = current_user.sponsor
  end

  def update
    @sponsor = current_user.sponsor
    @errors = []

    respond_to do |format|
      if @sponsor.update_attributes(params[:sponsor])
        if @sponsor.logos_uploaded?
          @sponsor.unlock!
          SponsorsMailer.notify_logos_upload(@sponsor).deliver
          format.js { render :nothing => true, :status => :ok }
        else
          @errors << 'Both logos should be provided.'
          format.js { render :json => @errors, :status => :unprocessable_entity }
        end
      else
        @errors << @sponsor.errors.full_messages
        @errors.flatten!
        format.js { render :json => @errors, :status => :unprocessable_entity }
      end
    end
  end

end
