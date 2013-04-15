class Sponsor::KeySponsorshipDatesController < Sponsor::BaseController

  def index
    @sponsor_events = SponsorEvent.all
  end

end
