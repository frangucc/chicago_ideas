class Admin::MaterialsController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @materials = Material.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

  # standard CRUD functionality exists in the base AdminController

  # the detail page for this material
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
