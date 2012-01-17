module Websockets
  module Channels
    def chat_channel_name_for(chat)
      "project_#{chat.project.id}_chat_#{chat.id}"
    end

    def project_channel_name_for(project)
      "project_#{project.id}"
    end
  end
end