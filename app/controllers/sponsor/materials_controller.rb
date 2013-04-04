class Sponsor::MaterialsController < Sponsor::BaseController

  def index
    @materials = Material.all
  end

end
