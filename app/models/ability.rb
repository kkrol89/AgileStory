class Ability
  include CanCan::Ability

  def initialize(user)
    @memberships = user.memberships

    can [:show_project, :browse_memberships, :manage_tickets, :browse_chats, :use_chat], Project do |project|
      memberships_by_project_id(project.id).any? { |membership| membership.viewer? || membership.developer? || membership.admin? }
    end

    can [:manage_project, :manage_memberships, :manage_sprints, :manage_chats], Project do |project|
      memberships_by_project_id(project.id).any? { |membership| membership.admin? }
    end

    can [:change_profile], User do |user_being_changed|
      user.present? && user == user_being_changed
    end
  end

  def memberships_by_project_id(project_id)
    @memberships.select { |membership| membership.project_id == project_id }
  end
end
