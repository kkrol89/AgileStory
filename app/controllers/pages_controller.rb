class PagesController < ApplicationController
  before_filter :not_logged_in_only
  def show
  end

  def not_logged_in_only
    if current_user.present?
      flash.keep
      redirect_to projects_path if current_user.present?
    end
  end
end
