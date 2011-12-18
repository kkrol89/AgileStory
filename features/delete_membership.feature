Feature: Delete membership
  In order to manage memberships
  As a project admin
  I want to be able to delete project memberships

  Background:
    Given there exist users "user@example.org, member@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And user "member@example.org" has role "Developer" in project "Universe"

  Scenario: Delete project membership
    Given user "user@example.org" has role "Admin" in project "Universe"
    When I delete membership "member@example.org" in project "Universe"

    Then I should see successful membership deletion message
    And I should be on the project members page for "Universe"
    And I should not see member "member@example.org"

  Scenario Outline: Delete project membership as non-admin
    Given user "user@example.org" has role <role> in project "Universe"
    Then I am not able to delete membership "member@example.org" in project "Universe"

  Examples:
    | role        |
    | "Developer" |
    | "Viewer"    |