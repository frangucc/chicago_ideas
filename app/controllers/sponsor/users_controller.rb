class Sponsor::UsersController < Sponsor::BaseController

  def invite
    validate_params :user, :name, :email
    if User.where(:email => params[:user][:email]).present?
      @errors << 'Already a user of CIW'
    end

    if @errors.empty?
      user = User.invite!(:name  => params[:user][:name], :email => params[:user][:email], :is_sponsor => true, :is_admin_created => true)
      current_user.sponsor.sponsor_users.create(:user_id => user.id)
      respond_to do |format|
        format.js { render :nothing => true, :status => :ok }
      end
    else
      respond_to do |format|
        format.js { render :json => @errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  end

end
