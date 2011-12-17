Given /^user "([^"]*)" has role "([^"]*)" in project named "([^"]*)"$/ do |user_email, role_name, project_name|
  Project.find_by_name(project_name).add_member(User.find_by_email(user_email), User::ROLES[role_name.parameterize.to_sym])
end

Given /^user "([^"]*)" has roles "([^"]*)" in project named "([^"]*)"$/ do |user_email, roles, project_name|
  roles.split(", ").each do |role_name|
    Given %{user "#{user_email}" has role "#{role_name}" in project named "#{project_name}"}
  end
end

Then /^I should see member "([^"]*)" with role "([^"]*)" on the members list$/ do |user_email, role_name|
  page.find('.members tr', :text => user_email).should have_content(role_name)
end

When /^I edit membership of "([^"]*)"$/ do |user_email|
  page.find('.members tr', :text => user_email).click_link("Edit membership")
end

When /^I delete membership of "([^"]*)"$/ do |user_email|
  page.find('.members tr', :text => user_email).click_link("Delete membership")
end