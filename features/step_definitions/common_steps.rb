When /^I accept dialog window$/ do
  page.driver.browser.switch_to.alert.accept
end

Then /^I should see confirmation message$/ do
  Then %{I should see "Your account was successfully confirmed. You are now signed in."}
end

Then /^I should see login message$/ do
  Then %{I should see "Signed in successfully."}
end

Then /^I should see logout message$/ do
  Then %{I should see "Signed out successfully."}
end

