class Project::ChatsController < ApplicationController
  include Authorization::Login
  before_filter :authorize_manage, only: [:new, :create]

  def new
    @chat = Chat.new
  end

  def create
    @chat = project.chats.build(params[:chat])
    if @chat.save
      redirect_to project_path(project), :notice => I18n.t('chat_successfully_created')
    else
      render :new
    end
  end

  private
  def project
    @project ||= Project.find(params[:project_id])
  end

  def authorize_manage
    authorize! :manage_chats, project
  end
end
