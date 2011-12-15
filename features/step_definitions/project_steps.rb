Given /^there exists a project named "([^"]*)"$/ do |project_name|
  Factory(:project, :name => project_name)
end

Given /^user "([^"]*)" has role "([^"]*)" for project "([^"]*)"$/ do |user_email, role, project_name|
  Project.find_by_name(project_name).add_member(User.find_by_email(user_email), User::ROLES[role.parameterize.to_sym])
end

When /^I create project named "([^"]*)"$/ do |project_name|
  steps %Q{
    When I go to the new project page
    And I fill in the following:
      | Project name        | #{project_name}     |
      | Project description | Example description |
    And I press "Create Project"
    Then I should see "Project was successfully created"
  }
end
