Feature: Assign members
  In order to manage memberships
  As a project admin
  I want to be able to assign members to project

  Background:
    Given there exist users "user@example.org, member@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"

  Scenario: Assign members
    Given user "user@example.org" has role "Admin" in project "Universe"

    When I visit members assignment page for project "Universe"
    And I assign member "member@example.org" as "Developer"

    Then I should see successful member assignment message
    And I should be on the project members page for "Universe"
    And I should see member "member@example.org" with role "Developer" on the members list

  Scenario: Members roles
    Given user "user@example.org" has role "Admin" in project "Universe"

    When I visit members assignment page for project "Universe"
    Then I should be able to assign roles like "Admin, Developer, Viewer"

  Scenario Outline: Assign members as non-admin
    Given user "user@example.org" has role <role> in project "Universe"
    Then I am not able to assign members to project "Universe"

  Examples:
    | role        |
    | "Developer" |
    | "Viewer"    |