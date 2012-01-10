Feature: Edit ticket
  In order to manage tickets
  As a project member
  I want to be able to switch between sprints

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And there exist "2" sprints for project "Universe"
    And user "user@example.org" has role "Viewer" in project "Universe"

  @javascript
  Scenario: Change ticket title
    When I go to the show project page for "Universe"
    Then I should see sprint "Sprint 2" in boards section

    When I switch to sprint "Sprint 1"
    Then I should see sprint "Sprint 1" in boards section