class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied, with: :resource_access_denied
  rescue_from Authorization::Login::LoginRequired, with: :login_access_denied

  private
  def resource_access_denied
    redirect_to root_path, :alert => t('not_allowed')
  end

  def login_access_denied
    redirect_to new_user_session_path, :alert => t('please_log_in')
  end
end

