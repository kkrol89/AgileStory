Feature: Edit membership
  In order to manage memberships
  As a a project admin
  I want to be able to edit project memberships

  Background:
    Given there exist users "user@example.org, member@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And user "member@example.org" has role "Developer" in project "Universe"

  Scenario: Edit project membership
    Given user "user@example.org" has role "Admin" in project "Universe"
    When I edit memberships of project "Universe"
    And I change role of member "member@example.org" to "Viewer"

    Then I should see successful membership update message
    And I should be on the project members page for "Universe"
    And I should see member "member@example.org" with role "Viewer" on the members list

  Scenario Outline: Edit project membership as non-admin
    Given user "user@example.org" has role <role> in project "Universe"
    Then I am not able to edit membership of "member@example.org" in project "Universe"
  
  Examples:
    | role        |
    | "Developer" |
    | "Viewer"    |