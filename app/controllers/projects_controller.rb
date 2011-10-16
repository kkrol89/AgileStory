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

  def show
    @project = Project.find(params[:id])
  end

  def index
    @projects = Project.all
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to projects_path, :notice => I18n.t('project_successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).delete
    redirect_to projects_path, :notice => I18n.t('project_successfully_deleted')
  end
end

