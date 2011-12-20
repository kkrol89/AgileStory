class UsersController < ApplicationController
  before_filter :require_user
  before_filter :authorize_profile_change, only: [:edit, :update]

  def edit
    user
  end

  def update
    if user.update_attributes(params[:user])
      sign_in(user, :bypass => true)
      redirect_to root_path, :notice => I18n.t('profile_successfully_updated')
    else
      render :edit
    end
  end

  private
  def user
    @user ||= User.find_by_id(params[:id])
  end

  def authorize_profile_change
    authorize! :change_profile, user
  end
end
