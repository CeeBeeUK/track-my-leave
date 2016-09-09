class HomeController < ApplicationController
  def show
    redirect_to login_path unless session[:user_id]
  end

  def login
  end
end
