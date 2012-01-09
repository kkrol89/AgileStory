Feature: Edit ticket
  In order to manage tickets
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
    | "Developer" |
    | "Admin"     |
  
  Scenario: Edit ticket as viewer
    Given user "user@example.org" has role "Viewer" in project "Universe"
    Then I should not be able to edit ticket "Friends invitation feature" from project "Universe"

  @javascript
  Scenario: Edit ticket with cucumber scenario
    Given user "user@example.org" has role "Developer" in project "Universe"
    And ticket "Friends invitation feature" has cucumber scenario defined

    When I edit ticket "Friends invitation feature" from project "Universe"
    And I choose cucumber scenario

    Then I should not see cucumber scenario outline
    And I should see highlighted keywords in cucumber scenario

    When I fill in ticket title with "House feature"
    And I press "Update Ticket"

    And I should see successfull ticket update message
    And I should see ticket "House feature" on the tickets list