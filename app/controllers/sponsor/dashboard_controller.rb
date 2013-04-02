class Sponsor::DashboardController < Sponsor::BaseController

  def index
    @sponsor = current_user.sponsor
  end

end
