class UserController < ApplicationController
  def show
    authorize user
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
