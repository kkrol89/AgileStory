Feature: Sign up
  In order to authenticate users
  As a visitor
  I want to be able to sign in

  Scenario: Successful sign in
    Given there exists user with:
      | Email            | Password  |
      | user@example.org | secret    |

    When I go to the home page
    And I follow "Sign in"
    And I fill in the following:
      | Email    | user@example.org  |
      | Password | secret            |
    And I press "Sign in"

    Then I should see login message
    And I should be on the home page

  Scenario: Unsucessful sign in
    When I go to the home page
    And I follow "Sign in"
    And I fill in the following:
      | Email    | user@example.org  |
      | Password | secret            |
    And I press "Sign in"

    Then I should see "Invalid email or password."

  Scenario: Ommitting fields
    When I go to the home page
    And I follow "Sign in"
    And I press "Sign in"

    Then I should see "Invalid email or password."

  Scenario: Already signed in
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"

    When I go to the home page
    Then I should not see "Sign in"

