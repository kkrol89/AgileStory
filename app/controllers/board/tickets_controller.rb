class Board::TicketsController < Board::BaseController
  include Authorization::Login

  before_filter :authorize_manage, only: [:sort]

  def sort
    respond_to do |format|
      format.json do
        Ticket.transaction do
          tickets_with_pessimistic_lock

          update_tickets params[:tickets]
          render :json =>  { :notice => I18n.t('project_successfully_updated') }
        end
        project.broadcast_update_message
      end
    end
  end

  private
  def authorize_manage
    authorize! :manage_tickets, project
  end

  def update_tickets(tickets_ids)
    tickets_ids.each.with_index do |ticket_id, index|
      update_ticket ticket(ticket_id.to_i), params[:board_id].to_i, index+1
    end
  end

  def update_ticket(ticket, board_id, position)
    if ticket.present?
      ticket.lazy_notify do
        ticket.update_attribute :board_id, board_id if ticket.board_id != board_id
        ticket.update_attribute :position, position if ticket.position != position
      end
    end
  end

  def tickets_with_pessimistic_lock
    @tickets ||= project.tickets.where('tickets.id IN (?)', params[:tickets]).lock(true)
  end

  def ticket(id)
    ticket = tickets_with_pessimistic_lock.select { |ticket| ticket.id == id }.first
  end
end
