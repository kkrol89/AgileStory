Feature: Browse projects
  In order to manage projects
  As a user
  I want to be able browse projects based on roles

  Scenario: Admin is able to see, edit and delete project
    Given there exists user "admin@example.org"
    And I am logged in as user "admin@example.org"

    And there exists a project named "Project one"
    And user "admin@example.org" has role "Admin" for project "Project one"

    When I go to the projects page

    Then I should see "Show" within ".projects"
    And I should see "Edit" within ".projects"
    And I should see "Delete" within ".projects"

  Scenario Outline: Developer or viewer is able to only show project
    Given there exists user <email>
    And I am logged in as user <email>

    And there exists a project named <project>
    And user <email> has role <role> for project <project>

    When I go to the projects page

    Then I should see "Show" within ".projects"
    And I should not see "Edit" within ".projects"
    And I should not see "Delete" within ".projects"

    Examples:
    | email                   | role        | project       |
    | "developer@example.org" | "Developer" | "Project One" |
    | "viewer@example.org"    | "Viewer"    | "Project One" |