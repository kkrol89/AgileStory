Feature: Create ticket
  In order to manage tickets
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
    And I should see ticket "Friends invitation feature" in icebox

  Examples:
    | role        |
    | "Developer" |
    | "Admin"     |
  
  Scenario: Create ticket as viewer
    Given user "user@example.org" has role "Viewer" in project "Universe"
    Then I should not be able to create new ticket for project "Universe"

  @javascript
  Scenario: Create new ticket with cucumber scenario
    Given user "user@example.org" has role "Developer" in project "Universe"

    When I go to the new ticket page for "Universe"
    And I choose cucumber scenario
    Then I should see cucumber scenario outline

    When I fill in ticket title with "House feature"
    And I append example description to ticket scenario
    And I select "Icebox" from "Board"
    Then I should see highlighted keywords in cucumber scenario

    When I press "Create Ticket"
    Then I should see successfull ticket creation message
    And I should see ticket "House feature" in icebox