Feature: Edit project
  In order to manage projects
  As a user
  I want to be able edit projects

  Scenario: Edit project as admin
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project named "Project one"
    And user "user@example.org" has role "Admin" for project "Project one"

    When I go to the projects page
    And I follow "Edit" within ".projects"
    And I fill in the following:
      | Project name        | Project two         |
      | Project description | Changed description |
    And I press "Update Project"

    Then I should be on the projects page
    And I should see "Project was successfully updated"
    And I should see "Project two" within ".projects"

Scenario: Can not edit project as developer or viewer
   Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project named "Project one"
    And user "user@example.org" has role "Developer" for project "Project one"
    And user "user@example.org" has role "Viewer" for project "Project one"

    When I go to the projects page
    Then I should not see "Edit" within ".projects"