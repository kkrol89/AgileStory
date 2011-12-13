class Ability
  include CanCan::Ability

  def initialize(user)
    @memberships = user.memberships

    can :see, Project do |project|
      memberships_by_project_id(project.id).any? { |membership| membership.viewer? || membership.developer? || membership.admin? }
    end

    #FIXME join edit, delete and update
    can :edit, Project do |project|
      memberships_by_project_id(project.id).any? { |membership| membership.admin? }
    end

    can :delete, Project do |project|
      memberships_by_project_id(project.id).any? { |membership| membership.admin? }
    end
  end

  def memberships_by_project_id(project_id)
    @memberships.select { |membership| membership.project_id == project_id }
  end
end
