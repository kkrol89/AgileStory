When /^I attach file "([^"]*)" to ticket "([^"]*)" in project "([^"]*)"$/ do |file, ticket, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(ticket).click_link(ticket)
  attach_file("ticket_attachement_attachement", File.expand_path("features/support/#{file}"))
  click_button("Attach file")
end

Then /^I should see successfull ticket attachement creation message$/ do
  steps %Q{Then I should see "Ticket attachement was successfully created"}
end

Then /^I should see "([^"]*)" in ticket attachements for "([^"]*)" in project "([^"]*)"$/ do |file, ticket, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(ticket).click_link(ticket)
  steps %Q{ Then I should see "#{file}" within ".ticket_attachements"}
end

Then /^I should not be able to attach file to ticket "([^"]*)" in project "([^"]*)"$/ do |ticket, project|
  steps %Q{ When I go to the show project page for "#{project}" }
  ticket_row_for(ticket).click_link(ticket)
  page.should_not have_css('form.ticket_attachement')
end