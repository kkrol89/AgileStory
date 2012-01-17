Feature: Auto refresh
  In order to manage tickets
  As a project member
  I want to be able to assign ticket

  Background:
    Given there exist users "user@example.org, developer@example.org, viewer@example.org"
    And I am logged in as user "user@example.org"
    And there exists a project "Universe"
    And there exists a ticket "Friends invitation" for project "Universe" in "Icebox"
    And user "user@example.org" has role "Developer" in project "Universe"

  @javascript
  Scenario: Automatic page reload
    When I go to the show project page for "Universe"
    And I enable automatic refresh
    And someone changes ticket title from "Friends invitation" to "Tickets management"

    Then I should see ticket "Tickets management"
  
  @javascript
  Scenario: Manual page reload
    When I go to the show project page for "Universe"
    And someone changes ticket title from "Friends invitation" to "Tickets management"
    Then I should see project update notification

    When I use refresh button
    Then I should see ticket "Tickets management"