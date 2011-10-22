Feature: Sign up
  In order to authenticate users
  As a visitor
  I want to be able to sign out

  Scenario: Successful sign out
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"

    When I go to the home page
    And I follow "Sign out"
    Then I should see logout message

  Scenario: Not signed in
    When I go to the home page
    Then I should not see "Sign out"

