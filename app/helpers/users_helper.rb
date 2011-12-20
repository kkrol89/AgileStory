module UsersHelper
  def roles_as_form_collection
    User::ROLES.map do |key, value|
      [key.to_s.capitalize, value]
    end
  end
  def avatar_for(user)
    link_to image_tag(Gravatar.new(user.email).url), "http://www.gravatar.com", :target => 'blank' if user.present?
  end
end