Given /^there exists user "([^"]*)"$/ do |email|
  Factory(:user, :email => email)
end

Given /^there exist users "([^"]*)"$/ do |users_emails|
  users_emails.split(', ').each do |email|
    steps %{Given there exists user "#{email}"}
  end
end

Given /^there exists user with:$/ do |table|
  table.hashes.each do |hash|
    Factory(:user, :email => hash['Email'], :password => hash['Password'])
  end
end

Given /^I am logged in as user "([^"]*)"$/ do |email|
  user_password = Factory.attributes_for(:user)[:password]
  steps %Q{
    When I go to the new user session page
    And I fill in "Email" with "#{email}"
    And I fill in "Password" with "#{user_password}"
    And I press "Sign in"
  }
end

When /^I log out$/ do
  steps %Q{When I follow "Sign out"}
end

When /^I log in as "([^"]*)" with password "([^"]*)"$/ do |email, password|
  steps %Q{
    When I go to the new user session page
    And I fill in "Email" with "#{email}"
    And I fill in "Password" with "#{password}"
    And I press "Sign in"
  }
end

When /^I change my email to "([^"]*)"$/ do |email|
  user_password = Factory.attributes_for(:user)[:password]
  page.find('#top_bar #user_info .email a').click
  steps %Q{
    When I fill in the following:
      | Email                 | #{email}         |
      | Password              | #{user_password} |
      | Password confirmation | #{user_password} |
    And I press "Update Profile"
  }
end

When /^I change my password to "([^"]*)"$/ do |password|
  page.find('#top_bar #user_info .email a').click
  steps %Q{
    When I fill in the following:
      | Password              | #{password} |
      | Password confirmation | #{password} |
    And I press "Update Profile"
  }
end

Then /^I should see successful profile update message$/ do
  steps %Q{Then I should see "Your profile was successfully updated"}
end

