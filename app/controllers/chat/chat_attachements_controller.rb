class Chat::ChatAttachementsController < ApplicationController
  include Authorization::Login
  include DynamicRefresh::Chat

  before_filter :authorize_send, only: [:create]

  def create
    @chat_attachement = chat.chat_attachements.create! params[:chat_attachement].merge({:user => current_user})
    Websockets::PusherSender.new.send(:channel => 'chat_attachements_new', :event => 'chat_attachement_created', :message => refresh_message('.chat_attachements', @chat_attachement))
    redirect_to(project_chat_path(chat.project, chat))
  end

  private
  def chat
    @chat ||= Chat.find_by_id(params[:chat_id])
  end

  def authorize_send
    authorize! :use_chat, chat.project
  end
end
