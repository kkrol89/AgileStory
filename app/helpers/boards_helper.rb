module BoardsHelper
  def class_for_managed(user, project)
    'managed' if can? :manage_tickets, project
  end
end