class Admin::SponsorEventsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @sponsor_events = SponsorEvent.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

  # standard CRUD functionality exists in the base AdminController

  def new
    @parent = parent_model
    @model = new_model(default_model)
  end

  def edit
    @model = fetch_model
  end

  def create
    @parent = parent_model
    @model = new_model(params[model_name])
    @model = pre_create(@model)

    if @model.errors.empty? && @model.save
      if params[model_name][:notes]
        model_note(@model, params[model_name][:notes][:body])
      else
        model_note(@model, "#{@model.class.name.titlecase} was successfully created.")
      end
      redirect_to admin_sponsor_events_path, :notice => "#{@model.class.name.titlecase} was successfully created."
    else
      render :new
    end
  end

  def update
    @parent = parent_model
    @model = fetch_model
    @model = pre_update(@model)

    if @model.errors.empty? && @model.update_attributes(params[model_name])
      if params[model_name][:notes]
        model_note(@model, params[model_name][:notes][:body])
      else
        model_note(@model, "#{@model.class.name.titlecase} was successfully updated.")
      end
      redirect_to admin_sponsor_events_path, :notice => "#{@model.class.name.titlecase} was successfully updated."
    else
      render :edit
    end

  end

  def show
    @section_title = 'Detail'
    @sponsor_event = SponsorEvent.find(params[:id])
  end

  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this sponsor event
  def notes
    @sponsor_event = SponsorEvent.find(params[:id])
    @notes = @sponsor_event.notes.includes(:author).search_sort_paginate(params, :parent => @sponsor_event)
  end

end
