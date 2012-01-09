Feature: Send ticket attachement
  In order to manage tickets
  As a project member
  I want to be able to send ticket attachement

  Background:
    Given there exist users "sender@example.org, reader@example.org"
    And I am logged in as user "sender@example.org"
    And there exists a project "Universe"
    And there exists a ticket "Friends invitation feature" for project "Universe"

  Scenario Outline: Send ticket attachement
    Given user "sender@example.org" has role <role> in project "Universe"

    When I attach file "example_file.txt" to ticket "Friends invitation feature" in project "Universe"
    Then I should see successfull ticket attachement creation message
    And I should see "example_file.txt" in ticket attachements for "Friends invitation feature" in project "Universe"

  Examples:
    | role        |
    | "Admin"     |
    | "Developer" |
  
  Scenario: Send ticket attachement as viewer
    Given user "sender@example.org" has role "Viewer" in project "Universe"
    Then I should not be able to attach file to ticket "Friends invitation feature" in project "Universe"