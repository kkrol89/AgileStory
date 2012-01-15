Feature: Browse tickets
  In order to manage tickets
  As a project member
  I want to be able to browse tickets

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And user "user@example.org" has role "Developer" in project "Universe"
    And there exist tickets "Friends invitation, Sprint management" for project "Universe"

  Scenario: My tickets
    Given ticket "Friends invitation" is assigned to "user@example.org"

    When I go to the my tickets page
    Then I should see ticket "Friends invitation" in project "Universe" scope
    And I should not see "Sprint management"