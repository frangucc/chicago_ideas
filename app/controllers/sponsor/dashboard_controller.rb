class Sponsor::DashboardController < Sponsor::BaseController

  def index
    @sponsor = current_user.sponsor
    @upcoming_events = SponsorEvent.first(2)
  end

end
