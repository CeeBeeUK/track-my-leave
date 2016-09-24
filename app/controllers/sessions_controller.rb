class SessionsController < ApplicationController
  skip_after_action :verify_authorized

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:alert] = t('flash.non_moj_digital')
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
