Feature: Edit ticket
  In order to manage tickers
  As a project member
  I want to be able to edit ticket

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And there exists a ticket "Friends invitation feature" for project "Universe"

  Scenario Outline: Change ticket title
    Given user "user@example.org" has role <role> in project "Universe"

    When I change ticket title from "Friends invitation feature" to "Facebook invitation feature" in project "Universe"
    Then I should be on the show project page for "Universe"
    And I should see successfull ticket update message
    And I should see ticket "Facebook invitation feature" on the tickets list

  Examples:
    | role        |
    | "Viewer"    |
    | "Developer" |
    | "Admin"     |