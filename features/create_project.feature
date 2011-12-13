Feature: Create project
  In order to manage projects
  As a user
  I want to be able create projects

  Scenario: Create project
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"

    When I go to the projects page
    And I follow "Create new project"
    And I fill in the following:
      | Project name        | Project one         |
      | Project description | Example description |
    And I press "Create Project"

    Then I should be on the projects page
    And I should see "Project was successfully created"
    And I should see "Project one" on the "Projects" list

  Scenario: Project creator has admin role
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    
    When I create project named "Project One"
    And I go to the project members page for "Project One"
    Then I should see member "user@example.org" with role "Admin" on the members list

