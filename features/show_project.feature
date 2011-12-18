Feature: Show project
  In order to manage projects
  As a project member
  I want to be able view project

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"

  Scenario Outline: Show project
    Given user "user@example.org" has role <role> in project "Universe"
    Then I can view details page of project "Universe"

  Examples:
    | role        |
    | "Viewer"    |
    | "Developer" |
    | "Admin"     |
  
  Scenario: Show project as non-user
    Then I can not view details page of project "Universe"