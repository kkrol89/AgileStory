module UpdateNotifications
  def self.included(klass)
    klass.instance_eval do
      after_save :project_notify
      after_destroy :project_notify
      attr_accessor :silence_notify
    end
  end

  def lazy_notify(&block)
    silence_notify = true
    yield
    silence_notify = false
  end

  private
  def project_notify
    if project.present? && !silence_notify
      project.broadcast_update_message
    end
  end
end