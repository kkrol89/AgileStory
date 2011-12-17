Feature: browse members
  In order to manage memberships
  As a project member
  I want to be able to browse project memberships

Scenario Outline: Browse members
  Given there exists user <email>
  And I am logged in as user <email>
  And there exists a project named <project>
  And user <email> has role <role> in project named <project>

  And there exists user "user@example.org"
  And user "user@example.org" has role "Developer" in project named <project>

  When I go to the show project page for <project>
  And I follow "Members"

  Then I should see "user@example.org" within ".members"

  Examples:
  | email                   | role        | project       |
  | "admin@example.org"     | "Admin"     | "Project One" |
  | "developer@example.org" | "Developer" | "Project One" |
  | "viewer@example.org"    | "Viewer"    | "Project One" |