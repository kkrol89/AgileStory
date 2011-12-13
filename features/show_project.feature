Feature: Show project
  In order to manage projects
  As a user
  I want to be able view projects

  Scenario Outline: Show project
    Given there exists user <email>
    And I am logged in as user <email>
    And there exists a project named <project>
    And user <email> has role <role> for project <project>

    When I go to the projects page
    And I follow "Show" within ".projects"

    Then I should be on the show project page for <project>
    And I should see <project> within ".name"

    Examples:
    | email                   | role        | project       |
    | "admin@example.org"     | "Admin"     | "Project One" |
    | "developer@example.org" | "Developer" | "Project One" |
    | "viewer@example.org"    | "Viewer"    | "Project One" |
