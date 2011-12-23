Given /^there exists a ticket "([^"]*)" for project "([^"]*)"$/ do |ticket, project|
  Factory(:ticket, :title => ticket, :project => Project.find_by_name(project))
end

When /^I change ticket title from "([^"]*)" to "([^"]*)" in project "([^"]*)"$/ do |old_title, title, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(old_title).click_link("Edit")
  steps %Q{
    When I fill in the following:
      | Title       | #{title}            |
      | Description | Example description |
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
  ticket_row_for(ticket).click_link("Delete Ticket")
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
  ticket_row_for(ticket).should_not have_link("Delete Ticket")
end

Then /^I should not be able to edit ticket "([^"]*)" from project "([^"]*)"$/ do |ticket, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(ticket).should_not have_link("Edit Ticket")
end

Then /^I should not be able to create new ticket for project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the show project page for "#{project}"
    Then I should not see "New ticket"
  }
end