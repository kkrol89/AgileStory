class ProjectsController < ApplicationController
  before_filter :require_user

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(params[:project])
    if @project.save
      redirect_to projects_path, :notice => I18n.t('project_successfully_created')
    else
      render :new
    end
  end

  def index
    @projects = Project.all
  end
end

