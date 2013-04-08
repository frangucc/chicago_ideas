class Sponsor::BaseController < ApplicationController

  skip_before_filter :cache_rendered_page
  before_filter :authenticate_user!
  before_filter :require_sponsor_admin!
  before_filter :init

  protect_from_forgery
  layout "sponsor"

  def validate_params(model, *args)
    @errors ||= []
    args.each { |arg|
      @errors << "#{arg} can't be blank" if params[model][arg].blank?
    }
  end

  def init
    @sponsor = current_user.sponsor
  end

  protected

  def require_sponsor_admin!
    unless(current_user.is_sponsor)
      redirect_to root_path, :notice => 'you must be an sponsor admin to access this area'
    end
  end

end
