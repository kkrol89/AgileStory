Feature: Send chat message
  In order to make chat comunication possible
  As a user
  I want to be able to send chat messages

  Background:
    Given there exist users "sender@example.org, reader@example.org"
    And I am logged in as user "sender@example.org"
    And there exists a project "Universe"
    And there exists a chat "DevChat" for project "Universe"

  @javascript
  Scenario Outline: Send chat message
    Given user "sender@example.org" has role <role> in project "Universe"
    And user "reader@example.org" has role <role> in project "Universe"
    
    When I go to the chat "DevChat" page for project "Universe"
    And I send message "Hello!"
    And I receive websocket notification for message "Hello!"
    Then I should see message "Hello!" in chat window

    When I log out

    Given I am logged in as user "reader@example.org"
    When I go to the chat "DevChat" page for project "Universe"
    Then I should see message "Hello!" in chat window

  Examples:
    | role        |
    | "Admin"     |
    | "Developer" |
    | "Viewer"    |