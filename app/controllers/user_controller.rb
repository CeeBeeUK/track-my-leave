class UserController < ApplicationController
  def new
  end

  def show
    authorize user
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
