class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_user
    redirect_to new_user_session_path, :alert => t('please_log_in') unless user_signed_in?
  end
end

