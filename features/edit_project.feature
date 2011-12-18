Feature: Edit project
  In order to manage projects
  As a project admin
  I want to be able edit projects

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"

  Scenario: Edit project
    Given user "user@example.org" has role "Admin" in project "Universe"
    When I change name of the project "Universe" to "Cosmos"

    Then I should be on the projects page
    And I should see successful project update message
    And I should see project "Cosmos" on the projects page

  Scenario Outline: Edit project as non-admin
    Given user "user@example.org" has role <role> in project "Universe"
    Then I am not able to edit the project "Universe"

  Examples:
    | role        |
    | "Developer" |
    | "Viewer"    |