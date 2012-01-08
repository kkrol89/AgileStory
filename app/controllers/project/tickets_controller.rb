class Project::TicketsController < ApplicationController
  include Authorization::Login
  before_filter :authorize_manage, only: [:new, :create, :edit, :update, :destroy]
  before_filter :assign_project_users

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = project.tickets.build(params[:ticket])
    if @ticket.save
      redirect_to project_path(project), :notice => I18n.t('ticket_successfully_created')
    else
      assign_project_users
      render :new
    end
  end

  def edit
    @ticket = project.tickets.find(params[:id])
  end

  def update
    @ticket = project.tickets.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      redirect_to project_path(project), :notice => I18n.t('ticket_successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    project.tickets.find(params[:id]).destroy
    redirect_to project_path(project), :notice => I18n.t('ticket_successfully_deleted')
  end

  private
  def project
    @project ||= Project.find(params[:project_id])
  end

  def authorize_manage
    authorize! :manage_tickets, project
  end

  def assign_project_users
    @users = project.at_least_developers
  end
end
