Feature: Browse chats
  In order to manage chats
  As a user
  I want to be able to browse chats

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And there exists a chat "DevChat" for project "Universe"

  Scenario Outline: Browse My chats
    Given user "user@example.org" has role <role> in project "Universe"
    Then I should see chat "DevChat" for project "Universe" on my chats page

  Examples:
    | role        |
    | "Admin"     |
    | "Developer" |
    | "Viewer"    |
  
  Scenario Outline: Browse project chats
    Given user "user@example.org" has role <role> in project "Universe"
    Then I should see chat "DevChat" on project "Universe" chats page

  Examples:
    | role        |
    | "Admin"     |
    | "Developer" |
    | "Viewer"    |