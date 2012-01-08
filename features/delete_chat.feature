Feature: Delete chat
  In order to manage chats
  As a user
  I want to be able to delete chats

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And there exists a chat "DevChat" for project "Universe"

  Scenario: Delete chat as admin
    Given user "user@example.org" has role "Admin" in project "Universe"
    When I delete chat "DevChat" for project "Universe"

    Then I should see successfull chat deletion message
    And I should not see chat "DevChat" on project "Universe" chats page
  
  Scenario Outline: Delete chat as developer or viewer
    Given user "user@example.org" has role <role> in project "Universe"
    Then I should not be able to delete chat "DevChat" for "Universe"

  Examples:
    | role        |
    | "Developer" |
    | "Viewer"    |