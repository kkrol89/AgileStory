class SprintsController < ApplicationController
  include Authorization::Login
  before_filter :authorize_manage, only: [:new, :create]

  def new
    @sprint = project.sprints.build
  end

  def create
    @sprint = project.sprints.build(params[:sprint])
    if @sprint.save
      redirect_to project_path(project), :notice => I18n.t('sprint_successfully_created')
    else
      render :new
    end
  end

  private
  def project
    @project ||= Project.find(params[:project_id])
  end

  def authorize_manage
    authorize! :manage_sprints, project
  end
end
