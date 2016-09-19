class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    # Clear the previous response body to avoid a DoubleRenderError
    # when redirecting or rendering another view
    self.response_body = nil

    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to request.referer || root_path
  end
end
