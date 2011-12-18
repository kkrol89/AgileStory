Feature: Create project
  In order to manage projects
  As a user
  I want to be able create projects

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"

  Scenario: Create project
    When I create project "Universe"

    Then I should be on the projects page
    And I should see successful project creation message
    And I should see "Universe" on the "Projects" list

  Scenario: Project creator has admin role
    When I create project "Universe"
    And I go to the project members page for "Universe"

    Then I should see member "user@example.org" with role "Admin" on the members list