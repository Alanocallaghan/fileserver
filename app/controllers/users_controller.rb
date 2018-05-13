class UsersController < ApplicationController
  include WardenHelper

  before_action :authenticate!, only: [:index, :show]

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    check_user params[:id]
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation)
  end

end
