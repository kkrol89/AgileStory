Given /^there exists user "([^"]*)"$/ do |user_email|
  Factory(:user, :email => user_email)
end

Given /^there exist users "([^"]*)"$/ do |users_emails|
  users_emails.split(', ').each do |user_email|
    Given %{there exists user "#{user_email}"}
  end
end

Given /^there exists user with:$/ do |table|
  table.hashes.each do |hash|
    Factory(:user, :email => hash['Email'], :password => hash['Password'])
  end
end

Given /^I am logged in as user "([^"]*)"$/ do |user_email|
  user_password = Factory.attributes_for(:user)[:password]
  steps %Q{
    When I go to the new user session page
    And I fill in "Email" with "#{user_email}"
    And I fill in "Password" with "#{user_password}"
    And I press "Sign in"
  }
end


