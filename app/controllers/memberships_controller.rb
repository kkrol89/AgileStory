class MembershipsController < ApplicationController
  before_filter :require_user

  def index
    @memberships = Membership.where(:user_id => current_user.id, :project_id => params[:project_id])
  end
end
