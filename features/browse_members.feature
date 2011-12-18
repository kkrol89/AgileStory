Feature: browse members
  In order to manage memberships
  As a project member
  I want to be able to browse project memberships

  Background:
    Given there exist users "user@example.org, member@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And user "member@example.org" has role "Developer" in project "Universe"

  Scenario Outline: Browse project members
    Given user "user@example.org" has role <role> in project "Universe"

    When I browse memberships for project "Universe"
    Then I should see member "member@example.org" with role "Developer" on the members list

  Examples:
    | role        |
    | "Viewer"    |
    | "Developer" |
    | "Admin"     |