class ChatsController < ApplicationController
  include Authorization::Login

  def index
    @projects = Project.visible_for(current_user).includes(:chats)
  end  
end
