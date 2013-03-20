class MemberTypesController < ApplicationController

  before_filter :cache_rendered_page, :only => [:index]

  def index
    @member_types = MemberType.where(:year_id => Time.now.year).order("min_price_in_cents ASC")
  end

end
