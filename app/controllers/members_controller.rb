class MembersController < ApplicationController

  # cache rendered versions of these pages
  before_filter :cache_rendered_page, :only => [:index]

  def index
    case params[:year_id]
    when "2012"
      @pillars = Member.joins([:year, :member_type]).where("years.id = '#{params[:year_id]}' AND member_types.title = 'Pillar'").sort_by(&:get_last_name)
      @benefactors = Member.joins([:year, :member_type]).where("years.id = '#{params[:year_id]}' AND member_types.title = 'Benefactor'").sort_by(&:get_last_name)
      @patrons = Member.joins([:year, :member_type]).where("years.id = '#{params[:year_id]}' AND member_types.title = 'Patron'").sort_by(&:get_last_name)

      @members = @patrons + @benefactors + @patrons
    when "2013"
      @collaborator = Member.joins(:member_type).where("member_types.title = 'Collaborator'")
      @producer     = Member.joins(:member_type).where("member_types.title = 'Producer'")
      @menlo        = Member.joins(:member_type).where("member_types.title = 'Menlo'")
      @edison       = Member.joins(:member_type).where("member_types.title = 'Edison'")

      @members = @collaborator + @producer + @menlo + @edison
    end
    @meta_data = {:page_title => "CIW Members", :og_title => "Chicago Ideas Week Members", :og_type => "website"}
  end

end
