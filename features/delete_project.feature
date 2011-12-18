Feature: Delete project
  In order to manage projects
  As a project admin
  I want to be able delete project

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"

  @javascript
  Scenario: Delete project
    Given user "user@example.org" has role "Admin" in project "Universe"
    When I delete project "Universe"

    Then I should be on the projects page
    And I should see successful project deletion message
    And I should not see "Universe" on the "Projects" list
  
  Scenario Outline: Delete project as non-admin
    Given user "user@example.org" has role <role> in project "Universe"
    Then I am not able to delete project "Universe"

  Examples:
    | role        |
    | "Developer" |
    | "Viewer"    |