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
    user = User.find params[:id]

    respond_to do |format|
      if user
        user.destroy
        format.js { render :nothing => true, :status => :ok }
      else
        format.js { render :nothing => true, :status => :unprocessable_entity }
      end
    end
  end

  def newsletter
    if current_user
      current_user.update_attribute(:newsletter, true)
    elsif existing_user = User.find_by_email(params[:user][:email])
      existing_user.update_attribute(:newsletter, true)
    else
      user = User.new(:email => params[:user][:email], :name => params[:user][:name])
      user.temporary_password = Devise.friendly_token[0,8]
      unless user.save
        render_json_response :error, :html => render_to_string('partials/_newsletter_form.html.haml', :layout => false), :notice => user.errors.first.present? ? user.errors.first.join(' ') : 'Could not save, please check email and name are valid.'
        return
      end
    end
    render_json_response :ok, :notice => 'Thank you, You have been added to the CIW newsletter.'
  end

end
