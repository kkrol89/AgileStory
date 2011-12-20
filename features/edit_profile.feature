Feature: Edit profile
  In order to manage my account
  As a user
  I want to be able to edit my profile

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"

  Scenario: Change password
    When I change my password to "newpassword"
    Then I should see successful profile update message

    When I log out
    And I log in as "user@example.org" with password "newpassword"
    Then I should see login message
    And I should be on the home page

  Scenario: Change email
    When I change my email to "john@example.org"
    Then I should see successful profile update message
    And I should see "john@example.org" on the top bar

  Scenario: Edit another user profile
    Given there exists user "ryan@example.org"
    When I go to the edit profile page for "ryan@example.org"
    Then I should be on the home page
    And I should see access denied message