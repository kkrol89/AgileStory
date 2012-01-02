When /^I receive websocket notification for message "([^"]*)"$/ do |message|
  page.execute_script('window.chat.message_created($(".chat_window .messages").append("<div class=\'message\'>konrad.krol89@gmail.com, 02.01.2012 19:14:  ' + message + '<\/div>\n"));')
end