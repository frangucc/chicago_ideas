class Sponsor::SponsorUsersController < Sponsor::BaseController

  def edit
  end

  def update
    @sponsor_user = current_user.sponsor_user

    respond_to do |format|
      if @sponsor_user.update_attributes(params[:sponsor_user])
        SponsorsMailer.notify_logos_upload(@sponsor_user).deliver
        format.js { render :nothing => true, :status => :ok }
      else
        format.js { render :json => @sponsor_user.errors.full_messages, :status => :unprocessable_entity }
      end
    end
  end

end
