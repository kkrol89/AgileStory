class Ability
  include CanCan::Ability

  def initialize(user)
    @memberships = user.memberships

    can :show, Project do |project|
      memberships_by_project_id(project.id).any? { |membership| membership.viewer? || membership.developer? || membership.admin? }
    end

    can [:edit, :update, :delete, :destroy], Project do |project|
      memberships_by_project_id(project.id).any? { |membership| membership.admin? }
    end
  end

  def memberships_by_project_id(project_id)
    @memberships.select { |membership| membership.project_id == project_id }
  end
end
