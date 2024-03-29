class Ticket::EstimationsController < Ticket::BaseController
  include Authorization::Login
  before_filter :authorize_manage, only: [:create]

  def create
    respond_to do |format|
      ticket.points = params[:estimation].to_i
      format.json do
        render :json => (
          if ticket.save
            { :notice => I18n.t('ticket_successfully_updated') }
          else
            { :error => I18n.t('error_occured') }
          end
        ).to_json
      end
    end
  end

  private
  def authorize_manage
    authorize! :manage_tickets, project
  end
end
