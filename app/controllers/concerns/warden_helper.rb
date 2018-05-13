module WardenHelper
  extend ActiveSupport::Concern

  included do
    helper_method :warden, :log_in?, :current_user

    # prepend_before_action :authenticate!
  end

  def log_in user
    warden.set_user user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out!
    warden.logout
    warden.clear_strategies_cache!
  end

  def current_user
    warden.user
  end

  def check_user id
    if current_user[:id].to_s != id
      throw(:warden)
    end
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end

  def unauthorised
    throw(:warden)
  end
end

