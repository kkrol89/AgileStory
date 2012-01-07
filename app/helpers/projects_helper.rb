module ProjectsHelper
  def point_scales_as_form_collection
    Project::POINT_SCALES.map do |key, value|
      [key.to_s.capitalize, value]
    end
  end
end
