Feature: Assign members
  In order to manage memberships
  As a an project admin
  I want to be able to assign members to project

Scenario: Assign members as admin
  Given there exist users "admin@example.org, developer@example.org"
  And I am logged in as user "admin@example.org"
  And there exists a project named "Project One"
  And user "admin@example.org" has role "Admin" in project named "Project One"
  
  When I go to the show project page for "Project One"
  And I follow "Members"
  And I follow "Assign member"
  Then I should see options "Admin, Developer, Viewer" in "Role" select box
  
  When I select "developer@example.org" from "User"
  And I select "Developer" from "Role"
  And I press "Assign member"

  Then I should see "Member successfully assigned"
  And I should be on the project members page for "Project One"
  And I should see member "developer@example.org" with role "Developer" on the members list

Scenario: Assign members as developer or viewer
  Given there exists user "user@example.org"
  And I am logged in as user "user@example.org"
  And there exists a project named "Project One"
  And user "user@example.org" has role "Developer" in project named "Project One"
  And user "user@example.org" has role "Viewer" in project named "Project One"

  When I go to the show project page for "Project One"
  And I follow "Members"
  Then I should not see "Assign member"

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