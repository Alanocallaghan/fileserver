class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token


  before_action :authenticate!, only: [:list, :show]

# protect_from_forgery :except => [:link]

  # def show
  #   # render plain: params[:project].inspect
  #   redirect_to("/#{params[:project]}/#{params[:file]}")
  # end

  def list
    @reports = User.find(current_user[:id]).reports
  end

  def show
    # render plain: params[:path].inspect



    ## Ensure user is logged in
    if User.find(current_user[:id]).reports.find_by_name(params[:project]).nil?
    	if request.referer.nil?
    		throw(:warden)
    	else
	      previous_path = URI(request.referer).path
	      if previous_path.start_with?('/reports')
	      	redirect_to "#{previous_path}#{request.fullpath.sub("/reports", "")}"
	  	  else
	        throw(:warden)
	      end
	    end
    else

	    # if params[:path].nil?
	      filename = "reports/#{params[:project]}/index.html"
	    # else

    		filename = "reports/#{params[:project]}/#{params[:path]}"
    		filename = "#{filename}.#{params[:format]}" unless params[:format].nil?

		    filename = "#{filename}/index.html" unless File.file?(filename)
	    # end

	      render :file => "#{filename}",
	        layout: false
    end

  end
end
