Feature: Create chat
  In order to manage chats
  As a project admin
  I want to be able to create chat

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"

  Scenario: Create Chat
    Given user "user@example.org" has role "Admin" in project "Universe"
    When I create new chat titled "DevChat" for project "Universe"

    Then I should see successful chat creation message
    And I should be on the chats page for project "Universe"
    
    Then I should see chat "DevChat" for project "Universe" on my chats page
    And I should see chat "DevChat" on project "Universe" chats page

  Scenario Outline: Create chat as non-admin
    Given user "user@example.org" has role <role> in project "Universe"
    Then I am not able to create chat for project "Universe"

  Examples:
    | role        |
    | "Developer" |
    | "Viewer"    |