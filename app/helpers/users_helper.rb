module UsersHelper
  def roles_as_form_collection
    User::ROLES.map do |key, value|
      [key.to_s.capitalize, value]
    end
  end
end