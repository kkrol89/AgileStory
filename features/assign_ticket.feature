Feature: Assign ticket
  In order to manage tickets
  As a project member
  I want to be able to assign ticket

  Background:
    Given there exist users "user@example.org, developer@example.org, viewer@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And there exists a ticket "Friends invitation feature" for project "Universe"
    And user "user@example.org" has role "Developer" in project "Universe"

  Scenario: Change ticket assignment
    Given user "developer@example.org" has role "Developer" in project "Universe"
    When I edit ticket "Friends invitation feature" from project "Universe"
    And I change assignment to "developer@example.org"
    And I should see successfull ticket update message
  
  Scenario: Unable to assign to project viewer
    Given user "viewer@example.org" has role "Viewer" in project "Universe"
    When I edit ticket "Friends invitation feature" from project "Universe"
    Then I should not be able to assign ticket to "viewer@example.org"
  
  Scenario: Assign ticket from view ticket page
    Given user "viewer@example.org" has role "Developer" in project "Universe"
    When I view ticket "Friends invitation feature" from project "Universe"
    And I use ticket action "Assign to me"

    Then I should see successfull ticket update message
    And ticket "Friends invitation feature" from project "Universe" should be assigned to "user@example.org"