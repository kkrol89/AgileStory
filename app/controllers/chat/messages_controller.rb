class Chat::MessagesController < ApplicationController
  include Authorization::Login
  respond_to :js
  before_filter :authorize_send, only: [:create]

  def create
    @message = chat.messages.create! params[:message].merge({:user => current_user})
  end

  private
  def chat
    @chat ||= Chat.find_by_id(params[:chat_id])
  end

  def authorize_send
    authorize! :use_chat, chat.project
  end
end
