class UserController < ApplicationController
  def show
    authorize user
  end

  def edit
    authorize user
  end

  # def update
  #   user.assign_attributes(user_params)
  #   authorize user
  #
  #   if user.save
  #     flash[:notice] = 'Profile was successfully updated'
  #
  #     redirect_to update_redirect_path
  #   end
  # end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
