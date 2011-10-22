Feature: Create project
  In order to manage projects
  As a user
  I want to be able create projects

  Scenario: Successful project creation
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

  Scenario: Unsuccessful project creation
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"

    When I go to the projects page
    And I follow "Create new project"
    And I fill in the following:
      | Project name        |                     |
      | Project description | Example description |
    And I press "Create Project"

    Then I should see "Project name can't be blank"

