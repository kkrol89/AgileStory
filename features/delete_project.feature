Feature: Delete project
  In order to manage projects
  As a user
  I want to be able delete projects

  @javascript
  Scenario: Successful project deletion
    Given there exists an user with:
      | Email            | Password  |
      | user@example.org | secret    |
    And I am logged in as an user "user@example.org" with password "secret"
    And there exists a project named "Project one" for "user@example.org"

    When I go to the projects page
    And I follow "Delete" within ".projects"
    And I accept dialog window

    Then I should be on the projects page
    And I should see "Project was successfully deleted"
    And I should not see "Project one" within ".projects"

