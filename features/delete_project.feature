Feature: Delete project
  In order to manage projects
  As a user
  I want to be able delete projects

  @javascript
  Scenario: Successful project deletion
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project named "Project one"
    And user "user@example.org" has role "Admin" for project "Project one"

    When I go to the projects page
    And I follow "Delete" within ".projects"
    And I accept dialog window

    Then I should be on the projects page
    And I should see "Project was successfully deleted"
    And I should not see "Project one" on the "Projects" list

