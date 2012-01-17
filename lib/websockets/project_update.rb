module Websockets::ProjectUpdate
  include Websockets::Channels

  def self.included(klass)
    klass.instance_eval do
      after_save :broadcast_update_message
      after_destroy :broadcast_update_message
    end
  end

  def broadcast_update_message
    Websockets::PusherSender.new.send(:channel => project_channel_name_for(self), :event => 'project_update', :message => 'Project has been updated')
  end
end