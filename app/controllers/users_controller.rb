class UsersController < ApplicationController
  
  def update
    @user = User.find_by_email(params[:user][:email])
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  protected

  def user_params
    params.require(:user).except!(:current_password).permit!
  end

end
