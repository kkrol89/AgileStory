Given /^there exists a ticket "([^"]*)" for project "([^"]*)"$/ do |ticket, project|
  Factory(:ticket, :title => ticket, :board => Project.find_by_name(project).icebox)
end

Given /^there exist tickets "([^"]*)" for project "([^"]*)"$/ do |tickets, project|
  tickets.split(', ').each do |ticket|
    steps %Q{Given there exists a ticket "#{ticket}" for project "#{project}"}
  end
end

Given /^there exists a ticket "([^"]*)" for project "([^"]*)" in "([^"]*)"$/ do |ticket, project, board|
  Factory :ticket, :title => ticket, :board => Project.find_by_name(project).boards.find_by_type(board)
end

Given /^ticket "([^"]*)" has cucumber scenario defined$/ do |ticket|
  description = "Given I have a one House\nWhen I go to the houses page\nThen I should see my house"
  Ticket.find_by_title(ticket).update_attribute(:description, description)
end

Given /^ticket "([^"]*)" is assigned to "([^"]*)"$/ do |ticket, user|
  ticket = Ticket.find_by_title(ticket)
  ticket.user = User.find_by_email(user)
  ticket.save!
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
    And I select "Icebox" from "Board"
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

When /^I estimate ticket "([^"]*)" to "([^"]*)" points$/ do |ticket, points|
  ticket_row_for(ticket).find('select').select(points)
end

When /^I view ticket "([^"]*)" from project "([^"]*)"$/ do |ticket, project|
  steps %Q{When I go to the show project page for "#{project}"}
  ticket_row_for(ticket).click_link(ticket)
end

When /^I use ticket action "([^"]*)"$/ do |action|
  within('.ticket .actions') { click_link(action) }
end

When /^I drag ticket "([^"]*)" from "([^"]*)" to "([^"]*)"$/ do |ticket, source, target|
  ticket = page.find('.board', :text => source).find('li.ticket', :text => ticket)
  ticket.drag_to page.find('.board', :text => target).find('.tickets ol')
end

When /^someone changes ticket title from "([^"]*)" to "([^"]*)"$/ do |ticket, new_title|
  Ticket.find_by_title(ticket).update_attribute(:title, new_title)
  page.execute_script('window.update_notifier.handler("Project has been updated");')
end

Then /^I should see "([^"]*)" board assignment$/ do |board|
  within('.ticket .board') { page.should have_content(board) }
end

Then /^I should not be able to drag tickets$/ do
  page.should_not have_css('.board.managed')
end

Then /^ticket "([^"]*)" from project "([^"]*)" should be assigned to "([^"]*)"$/ do |ticket, project, user|
  steps %Q{When I view ticket "#{ticket}" from project "#{project}"}
  within('.ticket .user') { page.should have_content(user) }
end

Then /^I should see "([^"]*)" points estimation$/ do |points|
  within ('.ticket .points') { page.should have_content(points) }
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

Then /^I should see ticket "([^"]*)" in icebox$/ do |ticket|
  within '.icebox .tickets' do
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

Then /^I should be able to use ticket actions$/ do
  within('.ticket') { page.should have_css('.actions') }
end

Then /^I should not be able to use ticket actions$/ do
  within('.ticket') { page.should_not have_css('.actions') }
end

Then /^I should see ticket "([^"]*)"$/ do |ticket|
  page.should have_css('.ticket', :text => ticket)
end

Then /^I should see ticket "([^"]*)" in project "([^"]*)" scope$/ do |ticket, project|
  page.find('.project', :text => project).should have_content(ticket)
end
