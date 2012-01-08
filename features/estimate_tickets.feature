Feature: Estimate tickets
  In order to manage tickers
  As a project member
  I want to be able to estimate ticket

  Background:
    Given there exists user "user@example.org"
    And I am logged in as user "user@example.org"

  Scenario: Estimation for feature ticket story
    Given there exists a project "Universe" with "Linear" point scale
    And there exists a project "Cosmos" with "Fibonacci" point scale
    And there exists a project "Pulsar" with "Power" point scale
    And user "user@example.org" has role "Developer" in projects "Universe, Cosmos, Pulsar"

    When I go to the new ticket page for "Universe"
    Then I should be able to estimate in "Linear" point scale

    When I go to the new ticket page for "Cosmos"
    Then I should be able to estimate in "Fibonacci" point scale

    When I go to the new ticket page for "Pulsar"
    Then I should be able to estimate in "Power" point scale

  @javascript
  Scenario: No estimation for bug and task ticket stories
    Given there exists a project "Universe"
    And user "user@example.org" has role "Developer" in project "Universe"

    When I go to the new ticket page for "Universe"
    And I choose "Task" ticket story
    Then I should not be able to estimate

    When I choose "Bug" ticket story
    Then I should not be able to estimate