When /^I send chat attachement "([^"]*)"$/ do |attachement|
  attach_file("chat_attachement_attachement", File.expand_path("features/support/#{attachement}"))
  click_button("Upload attachement")
end

When /^I receive websocket notification for chat attachement "([^"]*)"$/ do |attachement|
  page.execute_script('window.chat.handle_websocket_event($(".chat_window .chat_attachements").append("<div class=\'chat_attachement\'>  <a href=\"' + ChatAttachement.find_by_attachement_file_name(attachement).attachement.url + '\" target=\"_blank\">' + attachement + '<\/a><\/div>"));')
end

Then /^I should see chat attachement "([^"]*)" in chat window$/ do |attachement|
  within '.chat_attachements' do
    page.should have_css('.chat_attachement', :content => attachement)
  end
end