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

Then /^I should see successfull ticket creation message$/ do
  steps %Q{Then I should see "Ticket was successfully created"}
end

Then /^I should see ticket "([^"]*)" on the tickets list$/ do |ticket|
  within '.tickets' do
    page.should have_content(ticket)
  end
end
