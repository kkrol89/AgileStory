Given /^there exists a chat "([^"]*)" for project "([^"]*)"$/ do |chat, project|
  Factory(:chat, :title => chat, :project => Project.find_by_name(project))
end

When /^I create new chat titled "([^"]*)" for project "([^"]*)"$/ do |chat, project|
  steps %Q{
    When I go to the show project page for "#{project}"
    And I follow "New chat"
    And I fill in "Chat Title" with "#{chat}"
    And I press "Create Chat"
  }
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
