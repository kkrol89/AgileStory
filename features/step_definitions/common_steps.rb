Then /^I should be logged in$/ do
  current_user.should_not be_nil
end
