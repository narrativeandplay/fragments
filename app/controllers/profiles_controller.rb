class ProfilesController < ApplicationController
  before_action :same_user_check

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    if @user.profile.update_attributes(profile_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:pen_name, :description)
  end

  def same_user_check
    redirect_to new_user_session_url unless current_user == User.find(params[:user_id])
  end
end
