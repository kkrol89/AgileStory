Given /^there exists an user with:$/ do |table|
  table.hashes.each do |hash|
    User.create!(:email => hash['Email'], :password => hash['Password']).confirm!
  end
end

Given /^I am logged in as an user "([^"]*)" with password "([^"]*)"$/ do |user_email, user_password|
  steps %Q{
    When I go to the new user session page
    And I fill in "Email" with "#{user_email}"
    And I fill in "Password" with "#{user_password}"
    And I press "Sign in"
  }
end

