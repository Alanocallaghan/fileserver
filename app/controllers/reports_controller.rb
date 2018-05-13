class ReportsController < ApplicationController
  
  before_action :authenticate!, only: [:list, :link]

# protect_from_forgery :except => [:link]

  # def show
  #   # render plain: params[:project].inspect
  #   redirect_to("/#{params[:project]}/#{params[:file]}")
  # end

  def list
    @reports = User.find(current_user[:id]).reports
  end

  def link
    # render plain: params[:path].inspect

    ## Ensure user is logged in
    if User.find(current_user[:id]).reports.find_by_name(params[:project]).nil?
      throw(:warden)
    end

    if params[:path].nil?
      render :file => "reports/#{params[:project]}/index.html", 
        layout: false
    else
      render :file => "reports/#{params[:project]}/#{params[:path]}.#{params[:format]}",
        layout: false
    end

  end
end
