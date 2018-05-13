class UnauthorisedController < ActionController::Metal
  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    self.response_body = "Unauthorised Action"
    self.status = :unauthorised
  end
end
