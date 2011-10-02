Feature: Sign up
  In order to authenticate users
  As a visitor
  I want to be able to sign out

  Scenario: Successful sign out
    Given there exists an user with:
      | Email            | Password  |
      | user@example.org | secret    |
    And I am logged in as an user "user@example.org" with password "secret"

    When I go to the home page
    Then I should see "Sign out"

    When I follow "Sign out"
    Then I should see logout message

  Scenario: Not signed in
    When I go to the home page
    Then I should not see "Sign out"

