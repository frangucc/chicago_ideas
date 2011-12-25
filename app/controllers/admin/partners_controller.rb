class Admin::PartnersController < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @section_title = 'List'
    @partners = Partner.search_sort_paginate(params)
  end

end
