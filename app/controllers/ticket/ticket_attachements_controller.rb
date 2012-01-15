class Ticket::TicketAttachementsController < Ticket::BaseController
  include Authorization::Login
  before_filter :authorize_manage, only: [:create]

  def create
    ticket.ticket_attachements.new params[:ticket_attachement]
    if ticket.save
      redirect_to project_ticket_path(project, ticket), :notice => I18n.t('ticket_attachement_successfully_created')
    else
      redirect_to project_ticket_path(project, ticket), :alert => 'Could not create ticket attachement'
    end
  end

  private
  def authorize_manage
    authorize! :manage_tickets, project
  end
end
