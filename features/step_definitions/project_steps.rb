Given /^there exists a project "([^"]*)"$/ do |project_name|
  Factory(:project, :name => project_name)
end

When /^I create project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the projects page
    And I follow "Create new project"
    And I fill in the following:
      | Project name        | #{project}          |
      | Project description | Example description |
    And I press "Create Project"
  }
end

When /^I delete project "([^"]*)"$/ do |project|
  steps %Q{ When I go to the projects page }
  project_row_for(project).click_link("Delete")
  steps %Q{ And I accept dialog window }
end

When /^I change name of the project "([^"]*)" to "([^"]*)"$/ do |project, new_name|
  steps %Q{ When I go to the projects page }
  project_row_for(project).click_link("Edit")
  steps %Q{
      When I fill in the following:
      | Project name        | #{new_name}         |
      | Project description | Example description |
    And I press "Update Project"
  }
end

Then /^I am not able to delete project "([^"]*)"$/ do |project|
  steps %Q{ When I go to the projects page }
  project_row_for(project).should_not have_link("Delete")
end

Then /^I am not able to edit the project "([^"]*)"$/ do |project|
  steps %Q{ When I go to the projects page }
  project_row_for(project).should_not have_link("Edit")
end

Then /^I should see successful project creation message$/ do
  steps %Q{Then I should see "Project was successfully created"}
end

Then /^I should see successful project deletion message$/ do
  steps %Q{Then I should see "Project was successfully deleted"}
end

Then /^I should see successful project update message$/ do
  steps %Q{Then I should see "Project was successfully updated"}
end

Then /^I should( not)? see project "([^"]*)" on the projects page$/ do |not_value, project|
  steps %Q{
    When I go to the projects page
    Then I should#{not_value} see "#{project}" within ".projects"
  }
end

Then /^I can view details page of project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the projects page
    And I follow "#{project}" within ".projects"

    Then I should be on the show project page for "#{project}"
    And I should see "#{project}" within ".name"
  }
end

Then /^I can not view details page of project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the projects page
    Then I should not see "#{project}" within ".projects"
  }
end