Given /^user "([^"]*)" has role "([^"]*)" in project named "([^"]*)"$/ do |user_email, role_name, project_name|
  Project.find_by_name(project_name).add_member(User.find_by_email(user_email), Role::ROLES[role_name.parameterize.to_sym])
end

Then /^I should see member "([^"]*)" with role "([^"]*)" on the members list$/ do |user_email, role_name|
  within ".members" do
    page.should have_content(user_email)
    page.should have_content(role_name)
  end
end
