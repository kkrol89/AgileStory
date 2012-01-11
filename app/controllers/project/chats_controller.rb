class Project::ChatsController < Project::BaseController
  include Authorization::Login
  before_filter :authorize_manage, only: [:new, :create, :destroy]
  before_filter :authorize_browse, only: [:show, :index]

  def new
    @chat = Chat.new
  end

  def create
    @chat = project.chats.build(params[:chat])
    if @chat.save
      redirect_to project_chats_path(project), :notice => I18n.t('chat_successfully_created')
    else
      render :new
    end
  end

  def show
    @chat = project.chats.find(params[:id])
    @messages = @chat.messages.order('messages.created_at ASC').includes(:user)
    @chat_attachements = @chat.chat_attachements.order('chat_attachements.created_at ASC')
    @message = Message.new
    @chat_attachement = ChatAttachement.new
  end

  def index
    @chats = project.chats
  end

  def destroy
    project.chats.find(params[:id]).destroy
    redirect_to project_chats_path(project), :notice => I18n.t('chat_successfully_deleted')
  end

  private
  def authorize_browse
    authorize! :browse_chats, project
  end

  def authorize_manage
    authorize! :manage_chats, project
  end
end
