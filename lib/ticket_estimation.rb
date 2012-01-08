module TicketEstimation
  SCALES = {
    :linear => [0, 1, 2, 3, 4, 5, 6, 7],
    :fibonacci => [0, 1, 2, 3, 5, 8, 13, 21],
    :power => [0, 1, 2, 4, 8, 16, 32, 64]
  }

  def self.included(klass)
    klass.instance_eval do
      validate :verify_estimation_permission
      validate :verify_estimation_scale_compatibility

      def allowed_points_for(scale)
        SCALES[scale.to_sym]
      end
    end
  end

  def verify_estimation_permission
    if self.story != Ticket::TYPES[:feature] && self.points.to_i != 0
      errors.add(:points, "can't be assigned for this story type")
    end
  end
  private :verify_estimation_permission

  def verify_estimation_scale_compatibility
    if self.project.present? && self.points.present?
      unless Ticket.allowed_points_for(project.point_scale.to_sym).include?(self.points.to_i)
        errors.add(:points, "doesn't match #{project.point_scale.camelize} point scale") 
      end
    end
  end
  private :verify_estimation_scale_compatibility
end