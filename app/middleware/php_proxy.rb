class PhpProxy < Rack::Proxy

  def perform_request(env)
    request = Rack::Request.new(env)

    if request.path =~ %r{\.php} &&
	      env['warden'] &&
	      env['warden'].user

      ## have a user but using CanCan check if user has needed permissions
      # if env['warden'].user.can?(:access, :access_example_service)

      env["HTTP_HOST"] = ENV["HTTP_HOST"] ? URI(ENV["HTTP_HOST"]).host : "localhost:80"
      # ENV["PHP_PATH"] ||= '/manual/en/tutorial.firstpage.php'

      report = request.fullpath.sub(/\/reports\/(.*)\/.*/, '\1')
      # raise env.to_s
      if User.find(env['warden'].user[:id]).reports.find_by_name(report).nil?
      	throw(:warden)
      end

      # Rails 5 and above
      env['PATH_INFO'] = ENV["PHP_PATH"] || "/fileserver/#{request.fullpath}"

      env['content-length'] = nil

      super(env)
    else
      @app.call(env)
    end
  end

  def rewrite_response(triplet)
    status, headers, body = triplet

    # if you proxy depending on the backend, it appears that content-length isn't calculated correctly
    # resulting in only partial responses being sent to users
    # you can remove it or recalculate it here
    headers["content-length"] = nil

    triplet
  end
end
