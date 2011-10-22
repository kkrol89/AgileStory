class ProjectsController < ApplicationController
  before_filter :require_user

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.add_member(current_user, Role::ROLES[:admin])
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

