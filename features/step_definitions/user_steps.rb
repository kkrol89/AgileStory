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


