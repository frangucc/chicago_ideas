class MemberTypesController < ApplicationController
  def index
    @member_types = MemberType.order("min_price_in_cents ASC")
  end
end
