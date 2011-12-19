Feature: Create sprint
  In order to manage sprints
  As a project admin
  I want to be able to create sprint

  Background:
    Given there exist users "user@example.org, member@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"

  Scenario: Create Sprint
    Given user "user@example.org" has role "Admin" in project "Universe"
    When I create new sprint for project "Universe"

    Then I should see successful sprint creation message
    And I should be on the show project page for "Universe"
    And I should see sprint "Sprint 1"

  Scenario Outline: Assign members as non-admin
    Given user "user@example.org" has role <role> in project "Universe"
    Then I am not able to create sprints for project "Universe"

  Examples:
    | role        |
    | "Developer" |
    | "Viewer"    |