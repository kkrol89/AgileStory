Given /^there exists a project named "([^"]*)" for "([^"]*)"$/ do |project_name, user_email|
  Factory(:project, :name => project_name, :user => User.find_by_email(user_email) )
end

