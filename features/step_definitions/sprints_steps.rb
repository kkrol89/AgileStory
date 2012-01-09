When /^I create new sprint for project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "New sprint"
    And I fill in the following:
      | Sprint Goal       | Increase usability |
      | Sprint Start Date | 01-01-2012         |
      | Duration          | 14                 |
    And I press "Create Sprint"
  }
end

Then /^I am not able to create sprints for project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the show project page for "#{project}"
    Then I should not see "New sprint"
  }
end

Then /^I should see successful sprint creation message$/ do
  steps %Q{Then I should see "Sprint was successfully created"}
end

Then /^I should see sprint "([^"]*)"$/ do |sprint|
  page.should have_css('.boards .board.sprint', :text => sprint)
end
