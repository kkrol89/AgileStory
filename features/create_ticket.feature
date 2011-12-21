Feature: browse members
  In order to manage tickers
  As a project member
  I want to be able to create new ticket

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"

  Scenario Outline: Create new ticket
    Given user "user@example.org" has role <role> in project "Universe"

    When I create new ticket titled "Friends invitation feature" for project "Universe"
    Then I should be on the show project page for "Universe"
    And I should see successfull ticket creation message
    And I should see ticket "Friends invitation feature" on the tickets list

  Examples:
    | role        |
    | "Viewer"    |
    | "Developer" |
    | "Admin"     |