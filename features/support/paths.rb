module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the sign up page$/
      new_user_registration_path
    when /^the show project page for "([^"]*)"$/
      project_path(Project.find_by_name($1))
    when /^the project members page for "([^"]*)"$/
      project_memberships_path(Project.find_by_name($1))
    when /^the edit profile page for "([^"]*)"$/
      edit_user_path(User.find_by_email($1))
    when /^the my chats page$/
      chats_path
    when /^the chat "([^"]*)" page for project "([^"]*)"$/
      project_chat_path(Project.find_by_name($2), Chat.find_by_title($1))
    when /^the new ticket page for "([^"]*)"$/
      new_project_ticket_path(Project.find_by_name($1))
    when /^the chats page for project "([^"]*)"$/
      project_chats_path(Project.find_by_name($1))
    when /^the my tickets page$/
      tickets_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

