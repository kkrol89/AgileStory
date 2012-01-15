Given /^user "([^"]*)" has role "([^"]*)" in project "([^"]*)"$/ do |email, role, project|
  Project.find_by_name(project).add_member(User.find_by_email(email), User::ROLES[role.parameterize.to_sym])
end

Given /^user "([^"]*)" has role "([^"]*)" in projects "([^"]*)"$/ do |email, role, projects|
  projects.split(", ").each do |project|
    steps %Q{Given user "#{email}" has role "#{role}" in project "#{project}"}
  end
end

Given /^user "([^"]*)" has roles "([^"]*)" in project "([^"]*)"$/ do |email, roles, project_name|
  roles.split(", ").each do |role_name|
    steps %Q{Given user "#{email}" has role "#{role_name}" in project "#{project_name}"}
  end
end

When /^I edit membership of member "([^"]*)"$/ do |email|
  member_row_for(email).click_link("Edit")
end

When /^I edit memberships of project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Members"
  }
end

When /^I change role of member "([^"]*)" to "([^"]*)"$/ do |email, role|
  steps %Q{
    When I edit membership of member "#{email}"
    And I select "#{role}" from "Role"
    And I press "Update membership"
  }
end 

When /^I delete membership "([^"]*)" in project "([^"]*)"$/ do |email, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Members"
  }
  member_row_for(email).click_link("Delete")
end

When /^I visit members assignment page for project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Members"
    And I follow "Assign new member"
  }
end

When /^I browse memberships for project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Members"
  }
end

When /^I assign member "([^"]*)" as "([^"]*)"$/ do |email, role|
  steps %Q{
    When I fill in "User" with "#{email}"
    And I select "#{role}" from "Role"
    And I press "Assign member"
  }
end

Then /^I am not able to assign members to project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Members"
    Then I should not see "Assign new member"
  }
end

Then /^I am not able to edit membership of "([^"]*)" in project "([^"]*)"$/ do |email, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Members"
  }
  member_row_for(email).should_not have_link("Edit")
end

Then /^I am not able to delete membership "([^"]*)" in project "([^"]*)"$/ do |email, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Members"
  }
  member_row_for(email).should_not have_link("Delete")
end

Then /^I should see member "([^"]*)" with role "([^"]*)" on the members list$/ do |email, role_name|
  member_row_for(email).should have_content(role_name)
end

Then /^I should be able to assign roles like "([^"]*)"$/ do |roles|
  steps %Q{Then I should see options "#{roles}" in "Role" select box}
end

Then /^I should not see member "([^"]*)"$/ do |email|
  steps %Q{Then I should not see "#{email}" within ".members"}
end

Then /^I should see successful member assignment message$/ do
  steps %Q{Then I should see "Member successfully assigned"}
end

Then /^I should see successful membership deletion message$/ do
  steps %Q{Then I should see "Membership was successfully deleted"}
end

Then /^I should see successful membership update message$/ do
  steps %Q{Then I should see "Membership was successfully updated"}
end