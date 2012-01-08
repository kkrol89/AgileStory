module ProjectsHelper
  def point_scales_as_form_collection
    Project::POINT_SCALES.map do |key, value|
      [key.to_s.capitalize, value]
    end
  end

  def points_for_project(project)
    Ticket.allowed_points_for(project.point_scale)
  end
end
