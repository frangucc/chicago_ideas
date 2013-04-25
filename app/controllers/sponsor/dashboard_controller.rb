class Sponsor::DashboardController < Sponsor::BaseController

  def index
    @sponsor = current_user.sponsor
    upcoming_month = SponsorEvent.upcoming_month
    @upcoming_events = SponsorEvent.order_by_month(upcoming_month)
  end

end
