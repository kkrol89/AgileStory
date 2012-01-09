Given /^there exists a ticket "([^"]*)" for project "([^"]*)"$/ do |ticket, project|
  Factory(:ticket, :title => ticket, :board => Project.find_by_name(project).icebox)
end

Given /^ticket "([^"]*)" has cucumber scenario defined$/ do |ticket|
  description = "Given I have a one House\nWhen I go to the houses page\nThen I should see my house"
  Ticket.find_by_title(ticket).update_attribute(:description, description)
end

When /^I change ticket title from "([^"]*)" to "([^"]*)" in project "([^"]*)"$/ do |old_title, title, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(old_title).click_link(old_title)
  click_link("Edit")
  steps %Q{
    When I fill in the following:
      | Title       | #{title}            |
      | Description | Example description |
    When I select "Feature" from "Story type"
    And I select "1" from "Points"
    And I press "Update Ticket"
  }
end

When /^I create new ticket titled "([^"]*)" for project "([^"]*)"$/ do |ticket, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "New ticket"
    And I fill in the following:
      | Title       | #{ticket}           |
      | Description | Example description |
    And I press "Create Ticket"
  }
end

When /^I delete ticket titled "([^"]*)" from project "([^"]*)"$/ do |ticket, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(ticket).click_link(ticket)
  click_link("Delete")
end

When /^I choose cucumber scenario$/ do
  steps %Q{When I follow "Cucumber Scenario"}
end

When /^I fill in ticket title with "([^"]*)"$/ do |title|
  steps %Q{When I fill in "Title" with "#{title}"}
end

When /^I append example description to ticket scenario$/ do
  page.find('.cucumber .description').click
  description = "Given I have a one House\nWhen I go to the houses page\nThen I should see my house"
  fill_in('ticket_description', :with => description)
  page.find('.cucumber .description').click
end

When /^I edit ticket "([^"]*)" from project "([^"]*)"$/ do |ticket, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(ticket).click_link(ticket)
  click_link("Edit")
end

When /^I choose "([^"]*)" ticket story$/ do |story|
  steps %Q{When I select "#{story}" from "Story type"}
end

When /^I change assignment to "([^"]*)"$/ do |user|
  steps %Q{
    When I select "#{user}" from "Assigned to"
    And I press "Update Ticket"
  }
end

Then /^I should not be able to assign ticket to "([^"]*)"$/ do |user|
  within '#ticket_user_input' do
    page.should_not have_css('select option', :text => user)
  end
end

Then /^I should see highlighted keywords in cucumber scenario$/ do
  within '.cucumber .description' do
    page.should have_css('.keyword.outline')
  end
end

Then /^I should see successfull ticket creation message$/ do
  steps %Q{Then I should see "Ticket was successfully created"}
end

Then /^I should see successfull ticket update message$/ do
  steps %Q{Then I should see "Ticket was successfully updated"}
end

Then /^I should see ticket "([^"]*)" on the tickets list$/ do |ticket|
  within '.tickets' do
    page.should have_content(ticket)
  end
end

Then /^I should see successfull ticket deletion message$/ do
  steps %Q{Then I should see "Ticket was successfully deleted"}
end

Then /^I should not see ticket "([^"]*)" on the tickets list$/ do |ticket|
  within '.tickets' do
    page.should_not have_content(ticket)
  end
end

Then /^I should not be able to delete ticket "([^"]*)" from project "([^"]*)"$/ do |ticket, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(ticket).click_link(ticket)
  page.should_not have_link("Delete Ticket")
end

Then /^I should not be able to edit ticket "([^"]*)" from project "([^"]*)"$/ do |ticket, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(ticket).click_link(ticket)
  page.should_not have_link("Edit Ticket")
end

Then /^I should not be able to create new ticket for project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the show project page for "#{project}"
    Then I should not see "New ticket"
  }
end

Then /^I should see cucumber scenario outline$/ do
  within '.cucumber .description' do
    page.should have_content('Feature: Feature name')
    page.should have_content('In order to')
    page.should have_content('As a')
    page.should have_content('I want to')
    page.should have_content('Scenario:')
  end
end

Then /^I should not see cucumber scenario outline$/ do
  within '.cucumber .description' do
    page.should_not have_content('Feature: Feature name')
  end
end

Then /^I should be able to estimate in "([^"]*)" point scale$/ do |scale|
  within '#ticket_points' do
    TicketEstimation::SCALES[scale.parameterize.to_sym].each do |points|
      page.should have_content(points)
    end
  end
end

Then /^I should not be able to estimate$/ do
  page.should have_no_css('#ticket_points_input', :visible => true)
end

Then /^I should be able to view ticket "([^"]*)" from project "([^"]*)"$/ do |ticket, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(ticket).click_link(ticket)
  page.should have_content(ticket)
end
