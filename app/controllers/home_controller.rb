class HomeController < ApplicationController
  skip_after_action :verify_authorized

  def show
    redirect_to login_path unless session[:user_id]
  end

  def login
  end
end
