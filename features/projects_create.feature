Feature: Projects create
  In order to manage projects
  As a user
  I want to be able create projects

  Scenario: Successful project creation
    Given there exists an user with:
      | Email            | Password  |
      | user@example.org | secret    |
    And I am logged in as an user "user@example.org" with password "secret"

    When I go to the home page
    And I follow "Create project"
    And I fill in the following:
      | Project name        | Project one         |
      | Project description | Example description |
    And I press "Create project"

    Then I should be on the projects page
    And I should see "Project was successfully created"
    And I should see "Project one" within ".projects"

  Scenario: Unsuccessful project creation
    Given there exists an user with:
      | Email            | Password  |
      | user@example.org | secret    |
    And I am logged in as an user "user@example.org" with password "secret"

    When I go to the home page
    And I follow "Create project"
    And I fill in the following:
      | Project name        |                     |
      | Project description | Example description |
    And I press "Create project"

    Then I should see "Project name can't be blank"

  Scenario: Not logged in
    When I go to the home page
    Then I should not see "Create project"

