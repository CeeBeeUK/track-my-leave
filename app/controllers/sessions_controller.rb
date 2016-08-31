class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user
      session[:user_id] = user.id
    else
      flash[:alert] = 'The system is only available to MoJ Digital staff using a google mail account'
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
