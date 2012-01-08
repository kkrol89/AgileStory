Feature: View ticket
  In order to manage tickers
  As a project member
  I want to be able to view ticket

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And there exists a ticket "Friends invitation feature" for project "Universe"

  Scenario Outline: View ticket
    Given user "user@example.org" has role <role> in project "Universe"
    Then I should be able to view ticket "Friends invitation feature" from project "Universe"

  Examples:
    | role        |
    | "Developer" |
    | "Admin"     |
    | "Viewer"    |