Given /^there exists a chat "([^"]*)" for project "([^"]*)"$/ do |chat, project|
  Factory(:chat, :title => chat, :project => Project.find_by_name(project))
end

When /^I create new chat titled "([^"]*)" for project "([^"]*)"$/ do |chat, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Chats"
    And I follow "New chat"
    And I fill in "Chat Title" with "#{chat}"
    And I press "Create Chat"
  }
end

When /^I delete chat "([^"]*)" for project "([^"]*)"$/ do |chat, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Chats"
  }
  chat_row_for(chat).click_link("Delete")
end

Then /^I should see successfull chat deletion message$/ do
  steps %Q{Then I should see "Chat was successfully deleted"}
end

Then /^I should not see chat "([^"]*)" on project "([^"]*)" chats page$/ do |chat, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Chats"
    Then I should not see "#{chat}" within ".chats .chats_list"
  }
end

Then /^I should not be able to delete chat "([^"]*)" for "([^"]*)"$/ do |chat, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Chats"
  }
  chat_row_for(chat).should_not have_link("Delete")
end


Then /^I should see successful chat creation message$/ do
  steps %Q{Then I should see "Chat was successfully created"}
end

Then /^I should see chat "([^"]*)" for project "([^"]*)" on my chats page$/ do |chat, project|
  steps %Q{When I go to the my chats page}
  page.find('.project', :text => project).should have_css('.chat', :text => chat)
end

When /^I send message "([^"]*)"$/ do |message|
  steps %Q{
    When I fill in "Message" with "#{message}"
    And I press "Send message"
  }
end

Then /^I should see message "([^"]*)" in chat window$/ do |message|
  within '.chat_window' do
    page.should have_css('.message', :text => message)
  end
end

Then /^I am not able to create chat for project "([^"]*)"$/ do |project|
  steps %Q{
    When I go to the show project page for "#{project}"
    Then I should not see "New chat"

    When I go to the my chats page
    Then I should not see "New chat"
  }
end

Then /^I should see chat "([^"]*)" on project "([^"]*)" chats page$/ do |chat, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "Chats"
    Then I should see "#{chat}" within ".chats .chats_list"
  }
end