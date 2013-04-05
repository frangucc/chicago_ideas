class Sponsor::SponsorsController < Sponsor::BaseController

  def edit
   @sponsor = current_user.sponsor
  end

  def update
    @sponsor = current_user.sponsor

    if @sponsor.update_attributes(params[:sponsor])
      @sponsor.unlock!
      respond_to do |format|
        format.js { render :nothing => true, :status => :ok }
      end
    else
      respond_to do |format|
        format.js { render :text => @sponsor.errors.full_messages, :status => :unprocessable_entity }
      end
    end
  end

end
