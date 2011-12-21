class TicketsController < ApplicationController
  before_filter :require_user
  before_filter :authorize_manage, only: [:new, :create]

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = project.tickets.build(params[:ticket])
    if @ticket.save
      redirect_to project_path(project), :notice => I18n.t('ticket_successfully_created')
    else
      render :new
    end
  end

  private
  def project
    @project ||= Project.find(params[:project_id])
  end

  def authorize_manage
    authorize! :manage_tickets, project
  end
end
