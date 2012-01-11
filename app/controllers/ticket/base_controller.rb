class Ticket::BaseController < ApplicationController
  private
  def project
    ticket.project
  end

  def ticket
    @ticket ||= Ticket.find(params[:ticket_id])
  end
end