When /^I accept dialog window$/ do
  page.driver.browser.switch_to.alert.accept
end

Then /^I should see confirmation message$/ do
  steps %Q{Then I should see "Your account was successfully confirmed. You are now signed in."}
end

Then /^I should see login message$/ do
  steps %Q{Then I should see "Signed in successfully."}
end

Then /^I should see logout message$/ do
  steps %Q{Then I should see "Signed out successfully."}
end

Then /^I should( not)? see "([^"]*)" on the "([^"]*)" list$/ do |not_value, element_name, list_name|
  steps %Q{Then I should#{not_value} see "#{element_name}" within ".#{list_name.parameterize}"}
end

Then /^I should see options "([^"]*)" in "([^"]*)" select box$/ do |options, selectbox_name|
  options.split(', ').each do |option|
    page.should have_css('select option', :text => option)
  end
end

Then /^I should see "([^"]*)" on the top bar$/ do |content|
  within '#top_bar' do
    page.should have_content(content)
  end
end

Then /^I should see access denied message$/ do
  steps %Q{Then I should see "You are not allowed to view this page"}
end