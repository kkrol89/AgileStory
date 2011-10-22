Then /^I should see member "([^"]*)" with role "([^"]*)" on the members list$/ do |user_email, role_name|
  within ".members .member" do
    page.should have_content(user_email)
    page.should have_content(role_name)
  end
end
