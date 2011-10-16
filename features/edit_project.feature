Feature: Edit project
  In order to manage projects
  As a user
  I want to be able edit projects

  Scenario: Successful project creation
    Given there exists an user with:
      | Email            | Password  |
      | user@example.org | secret    |
    And I am logged in as an user "user@example.org" with password "secret"
    And there exists a project named "Project one" for "user@example.org"

    When I go to the projects page
    And I follow "Edit" within ".projects"
    And I fill in the following:
      | Project name        | Project two         |
      | Project description | Changed description |
    And I press "Update Project"

    Then I should be on the projects page
    And I should see "Project was successfully updated"
    And I should see "Project two" within ".projects"

  Scenario: Unsuccessful project creation
    Given there exists an user with:
      | Email            | Password  |
      | user@example.org | secret    |
    And I am logged in as an user "user@example.org" with password "secret"
    And there exists a project named "Project one" for "user@example.org"

    When I go to the projects page
    And I follow "Edit" within ".projects"
    And I fill in the following:
      | Project name        |                     |
      | Project description | Example description |
    And I press "Update Project"

    Then I should see "Project name can't be blank"

