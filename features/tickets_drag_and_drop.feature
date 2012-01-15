Feature: Tickets drag and drop
  In order to manage tickers
  As a project member
  I want to be able to drag and drop tickets

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"

  @javascript
  Scenario Outline: Tickets drag and drop
    Given there exists a project "Universe"
    And there exists a ticket "Friends invitation feature" for project "Universe" in "Icebox"
    And user "user@example.org" has role <role> in project "Universe"

    When I go to the show project page for "Universe"
    And I drag ticket "Friends invitation feature" from "Icebox" to "Backlog"
    Then I should see successful project update message

    When I view ticket "Friends invitation feature" from project "Universe"
    Then I should see "Backlog" board assignment

  Examples:
    | role        |
    | "Admin"     |
    | "Developer" |

  @javascript
  Scenario: Tickets drag and drop as viewer
    Given there exists a project "Universe"
    And there exists a ticket "Friends invitation feature" for project "Universe" in "Icebox"
    And user "user@example.org" has role "Viewer" in project "Universe"

    When I go to the show project page for "Universe"
    Then I should not be able to drag tickets