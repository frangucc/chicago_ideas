class Sponsor::DashboardController < Sponsor::BaseController

  def index
    @sponsor = current_user.sponsor
    @upcoming_events = Year.current_year.sponsor_events.first(2)
  end

end
