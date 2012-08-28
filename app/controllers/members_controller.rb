class MembersController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index]
  
  def index
    if params[:year_id].present?
      @members = Member.search_sort_paginate(params)
      
      @patrons = Member.joins([:year, :member_type]).where("years.id = '#{params[:year_id]}' AND member_types.name = 'Patron'").sort_by(&:get_last_name)
      @pillars = Member.joins([:year, :member_type]).where("years.id = '#{params[:year_id]}' AND member_types.name = 'Pillar'").sort_by(&:get_last_name)
      @benefactors = Member.joins([:year, :member_type]).where("years.id = '#{params[:year_id]}' AND member_types.name = 'Benefactor'").sort_by(&:get_last_name)
      
    end
    @meta_data = {:page_title => "CIW Members", :og_title => "Chicago Ideas Week Members", :og_type => "website"}
  end
  
end
