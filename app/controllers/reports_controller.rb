class ReportsController < ApplicationController
  protect_from_forgery :except => [:link]

  # def show
  #   # render plain: params[:project].inspect
  #   redirect_to("/#{params[:project]}/#{params[:file]}")
  # end

  def link
    # render plain: params[:path].inspect
    ## Ensure user is logged in
    render :file => "public/#{params[:project]}/#{params[:path]}", layout: false
  end
end
