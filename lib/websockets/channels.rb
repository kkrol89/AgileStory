module Websockets
  module Channels
    def chat_channel_name_for(chat)
      "project_#{chat.project.id}_chat_#{chat.id}"
    end
  end
end