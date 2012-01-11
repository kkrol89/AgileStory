class Project::TicketsController < ApplicationController
  include Authorization::Login
  include Authorization::Exceptions
  before_filter :authorize_manage, only: [:new, :create, :edit, :update, :destroy, :assign]
  before_filter :authorize_browse, only: [:show]
  before_filter :assign_project_users
  before_filter :assign_project_boards
  before_filter :project_board_authorization

  def new
    @ticket = Ticket.new
    @ticket.board = project.icebox
  end

  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      redirect_to project_path(project), :notice => I18n.t('ticket_successfully_created')
    else
      assign_project_users
      assign_project_boards
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

  def show
    @ticket = project.tickets.find(params[:id])
    @ticket_attachements = @ticket.ticket_attachements
    @ticket_attachement = TicketAttachement.new
  end

  def assign
    @ticket = project.tickets.find(params[:id])
    @ticket.user = current_user
    if @ticket.save
      redirect_to project_path(project), :notice => I18n.t('ticket_successfully_updated')
    else
      redirect_to project_ticket_path(project, @ticket), :alert => I18n.t('error_occured')
    end
  end

  private
  def project
    @project ||= Project.find(params[:project_id])
  end

  def board
    Board.find(params[:project][:board_id])
  end

  def authorize_manage
    authorize! :manage_tickets, project
  end

  def authorize_browse
    authorize! :browse_tickets, project
  end

  def assign_project_users
    @users = project.at_least_developers
  end

  def assign_project_boards
    @boards = project.boards
  end

  def project_board_authorization
    if params[:project].present? && params[:project][:board_id].present?
      unless project.boards.include?(board)
        raise Authorization::Exceptions::NotAllowed.new
      end
    end
  end
end
