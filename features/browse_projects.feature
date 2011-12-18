Feature: Browse projects
  In order to manage projects
  As a project member
  I want to be able browse projects

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"

  Scenario Outline: Browse projects
    Given user "user@example.org" has role <role> in project "Universe"
    Then I should see project "Universe" on the projects page

  Examples:
    | role        |
    | "Viewer"    |
    | "Developer" |
    | "Admin"     |
  
  Scenario: Browse projects as non-member
    Then I should not see project "Universe" on the projects page