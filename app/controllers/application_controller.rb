class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied, with: :resource_access_denied

  def require_user
    redirect_to new_user_session_path, :alert => t('please_log_in') unless user_signed_in?
  end

  private
  def resource_access_denied
    redirect_to root_path
  end
end

