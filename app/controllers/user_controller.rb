class UserController < ApplicationController
  def show
    authorize user
  end

  def edit
    authorize user
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
