Feature: User ticket actions
  In order to manage tickers
  As a project member
  I want to be able to use ticket actions

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And there exists a ticket "Friends invitation feature" for project "Universe"

  Scenario Outline: Use ticket actions
    Given user "user@example.org" has role <role> in project "Universe"
    When I view ticket "Friends invitation feature" from project "Universe"
    Then I should be able to use ticket actions
  Examples:
    | role        |
    | "Developer" |
    | "Admin"     |
  
  Scenario: Use ticket actions as viewer
    Given user "user@example.org" has role "Viewer" in project "Universe"
    When I view ticket "Friends invitation feature" from project "Universe"
    Then I should not be able to use ticket actions