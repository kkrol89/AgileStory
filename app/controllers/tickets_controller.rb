class TicketsController < ApplicationController
  include Authorization::Login
  def index
    @projects = current_user.projects.includes(:tickets).where('tickets.user_id = ?', current_user.id)
  end
end
