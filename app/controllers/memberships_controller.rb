class MembershipsController < ApplicationController
  before_filter :require_user

  def new
    project
    @membership = @project.memberships.build
  end
  
  def create
    project
    @membership = project.memberships.build(params[:membership])
    if @membership.save
      redirect_to project_memberships_path(project), :notice => 'Member successfully assigned'
    else
      render :new
    end
  end

  def index
    project
    @memberships = Membership.where(:project_id => params[:project_id])
  end

  private
  def project
    @project ||= Project.find(params[:project_id])
  end
end
