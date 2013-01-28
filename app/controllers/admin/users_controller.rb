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
    eval("user.#{params[:user][:role]}=true") unless params[:user][:role].blank?
    # when creating users, we assign them a temporary password and send it to them
    user.temporary_password = Devise.friendly_token[0,8]
    user.is_admin_created = true
    user
  end

  def pre_update(user)
    eval("user.#{params[:user][:role]}=true") unless params[:user][:role].blank?
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
    
  
end
