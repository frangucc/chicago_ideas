class MemberTypesController < ApplicationController

  def index
    current_year = Time.current.year
    @member_types = Year.find_by_id(current_year).member_types.order("min_price_in_cents ASC")
  end

end
