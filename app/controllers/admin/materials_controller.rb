class Admin::MaterialsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @materials = Material.search_sort_paginate(params)
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
      redirect_to admin_materials_path, :notice => "#{@model.class.name.titlecase} was successfully created."
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
      redirect_to admin_materials_path, :notice => "#{@model.class.name.titlecase} was successfully updated."
    else
      render :edit
    end

  end

  def show
    @section_title = 'Detail'
    @material = Material.find(params[:id])
  end

  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this material
  def notes
    @material = Material.find(params[:id])
    @notes = @material.notes.includes(:author).search_sort_paginate(params, :parent => @material)
  end

end
