Feature: Sign up
  In order to get application account
  As a visitor
  I want to be able to sign up

  Scenario: Successful sign up
    When I go to the home page
    And I follow "Sign up"
    And I fill in the following:
      | Email                 | user@example.org |
      | Password              | secret           |
      | Password confirmation | secret           |
    And I press "Sign up"

    Then I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed."
    And I should receive an email

    When I open the email
    And I follow "confirm" in the email

    Then I should see confirmation message
    And I should be on the home page

  Scenario: Invalid Email
    When I go to the home page
    And I follow "Sign up"
    And I fill in the following:
     | Email                 | email@invalid    |
     | Password              | secret           |
     | Password confirmation | secret           |
    And I press "Sign up"

    Then I should see "Email is invalid"

  Scenario: Password mismatch
    When I go to the home page
    And I follow "Sign up"
    And I fill in the following:
      | Email                 | user@example.org |
      | Password              | secret           |
      | Password confirmation | other            |
    And I press "Sign up"

    Then I should see "Password doesn't match confirmation"
    And the "Email" field should contain "user@example.org"

  Scenario: Ommiting fields
    When I go to the home page
    And I follow "Sign up"
    And I fill in the following:
      | Email                 |  |
      | Password              |  |
      | Password confirmation |  |
    And I press "Sign up"

    Then I should see "Email can't be blank"
    And I should see "Password can't be blank"

  Scenario: Already signed in
    Given there exists an user with:
      | Email            | Password  |
      | user@example.org | secret    |
    And I am logged in as an user "user@example.org" with password "secret"

    When I go to the home page
    Then I should not see "Sign up"

