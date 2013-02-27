require 'csv'
class Admin::UsersController < Admin::AdminController

  # if the password field is empty, allow the password to stay the same
  before_filter :delete_empty_password_params, :only => :update

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @section_title = 'List'

    @users = User.search_sort_paginate(params)
  end

  def export
    @users = User.all # get all the users
    respond_to do |format|
      format.csv { # CSV is the only format we're concerned with for now
        csv = CSV.generate do |row| # generated the CSV
          columns = User.csv_columns
          row << columns
          @users.each do |user|
            row << user.csv_attributes
          end
        end

    	# send .csv back to the browser
        send_data(csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=users_export_" << Date.today.to_s() << "_.csv")
      }
    end
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def new
    @model = new_model(default_model)
  end

  def edit
    @model = fetch_model
  end

  def show
    @section_title = 'Detail'
    @user = User.find(params[:id])
  end

  def create
    @parent = parent_model
    @model = new_model(params[model_name])
    @model = pre_create(@model)
    password = @model.temporary_password
    if @model.save
      AdminMailer.sponsor_admin_notification(@model, password).deliver if @model.is_sponsor
      redirect_to admin_users_path, notice: "#{@model.class.name.titlecase} was successfully created."
    else
      render :new
    end

  end

  def simulate
    @new_user = User.find params[:id]
    if (current_user.admin? || current_simulate_user) && @new_user
      unless current_simulate_user
        @simulate_user = current_user.simulate_user
        @simulate_user = current_user.create_simulate_user unless @simulate_user
        sign_in(:simulate_user, @simulate_user)
      end
      sign_out(current_user)
      sign_in(@new_user, :bypass => true)
      flash[:notice] = "Simulating user start..."
    else
      flash[:alert] = "You do not have permission"
    end
    if @new_user.is_sponsor?
      redirect_to sponsor_root_url
    else
      redirect_to admin_root_url
    end
  end

  def update
    @parent = parent_model
    @model = fetch_model

    @model = pre_update(@model)

    if @model.errors.empty? and @model.update_attributes(params[model_name])
      # allows for some basic controler specific functionality without redefining the create method
      redirect_to admin_users_path, notice: "#{@model.class.name.titlecase} was successfully updated."
    else
      render :edit
    end

  end
  # edit password form
  def edit_password
    @field_template = 'password'
    edit
  end
  def update_password
    @field_template = 'password'
    update
  end

  # admin controller callbacks
  # ---------------------------------------------------------------------------------------------------------

  # the admin area is allowed to update these protected attributes
  def pre_create(user)
    role =params[:user][:role]
    eval("user.#{role}=true") unless role.blank?
    # when creating users, we assign them a temporary password and send it to them
    user.temporary_password = Devise.friendly_token[0,8]
    user.is_admin_created = true
    validate_role user, role
    user
  end

  def pre_update(user)
    role = params[:user][:role]
    unless role.blank?
      user.admin = false
      user.is_sponsor = false
      user.is_speaker = false
      user.is_volunteer = false
      user.is_member = false
      eval("user.#{role}=true")
    end
    validate_role user, role
    user
  end

  # COLLECTION PAGES
  # ---------------------------------------------------------------------------------------------------------

  # a list of users who are also administrators
  def administrators
    @users = User.admin.search_sort_paginate(params)
  end

  # a list of users who are also staff members
  def staff
    @users = User.staff.search_sort_paginate(params)
  end

  # a list of users who are also speakers
  def speakers
    @users = User.speaker.search_sort_paginate(params)
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this user account
  def notes
    @user = User.find(params[:id])
    @notes = @user.notes.includes(:author).search_sort_paginate(params, :parent => @user)
  end



  # MEMBER PAGES (specifically for administrative users)
  # ---------------------------------------------------------------------------------------------------------

  # a log of what the user has done in the admin tool, these log entries are stored in mongodb
  def log_entries
    @user = User.find(params[:id])
    @log_entries = LogEntry.where(:user_id => @user.id).page(params[:page] || 1)
  end

  private

    #if the password field is empty, allow the password to stay the same
    # called from a before filter
    def delete_empty_password_params
      params[:user].delete :password if params[:user][:password].blank?
      params[:user].delete :password_confirmation if params[:user][:password_confirmation].blank?
    end

    def validate_role(user, role)
      if role == 'admin'
        password = params[:user][:creation_password] || ""
        user.errors.add(:creation_password, "wrong password") if password != "Fandango32@!"
      elsif role == 'is_sponsor'
        user.errors.add(:sponsor_id, "can't be blank") if params[:user][:sponsor_user_attributes][:sponsor_id].blank?
      end
      user
    end
end

