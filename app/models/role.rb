class Role
  ROLES = {:admin => 'admin', :developer => 'developer', :viewer => 'viewer'}

  def self.roles_as_form_collection
    ROLES.map do |key, value|
      [key.to_s.capitalize, value]
    end
  end
end
