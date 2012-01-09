class Ticket::TicketAttachementsController < ApplicationController
  include Authorization::Login
  before_filter :authorize_manage, only: [:create]

  def create
    ticket.ticket_attachements.create! params[:ticket_attachement]
    redirect_to project_ticket_path(project, ticket), :notice => I18n.t('ticket_attachement_successfully_created')
  end

  private
  def project
    ticket.project
  end

  def ticket
    @ticket ||= Ticket.find(params[:ticket_id])
  end

  def authorize_manage
    authorize! :manage_tickets, project
  end
end
