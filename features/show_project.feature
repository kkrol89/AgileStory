Feature: Show project
  In order to manage projects
  As a user
  I want to be able view projects

  Scenario: Show project
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project named "Project one" for "user@example.org"

    When I go to the projects page
    And I follow "Show" within ".projects"

    Then I should be on the show project page for "Project one"
    And I should see "Project one" within ".name"
    And I should see "user@example.org" within ".author"

