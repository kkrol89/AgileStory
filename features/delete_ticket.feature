Feature: Delete ticket
  In order to manage tickers
  As a project member
  I want to be able to delete ticket

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And there exists a ticket "Friends invitation feature" for project "Universe"

  Scenario Outline: Delete ticket
    Given user "user@example.org" has role <role> in project "Universe"

    When I delete ticket titled "Friends invitation feature" from project "Universe"
    Then I should be on the show project page for "Universe"
    And I should see successfull ticket deletion message
    And I should not see ticket "Facebook invitation feature" on the tickets list

  Examples:
    | role        |
    | "Developer" |
    | "Admin"     |

  Scenario: Delete ticket as viewer
    Given user "user@example.org" has role "Viewer" in project "Universe"
    Then I should not be able to delete ticket "Friends invitation feature" from project "Universe"