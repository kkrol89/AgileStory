Feature: Assign members
  In order to manage memberships
  As a a project admin
  I want to be able to edit project memberships

Scenario: Edit membership project as admin
  Given there exist users "admin@example.org, member@example.org"
  And I am logged in as user "admin@example.org"
  And there exists a project named "Project One"
  And user "admin@example.org" has role "Admin" in project named "Project One"
  And user "member@example.org" has role "Developer" in project named "Project One"
  
  When I go to the show project page for "Project One"
  And I follow "Members"
  Then I should see member "member@example.org" with role "Developer" on the members list

  When I edit membership of "member@example.org"
  And I select "Viewer" from "Role"
  And I press "Update membership"

  Then I should see "Membership was successfully updated"
  And I should be on the project members page for "Project One"
  And I should see member "member@example.org" with role "Viewer" on the members list

Scenario: Edit membership as developer or viewer
  Given there exist users "user@example.org, member@example.org"
  And I am logged in as user "user@example.org"
  And there exists a project named "Project One"
  And user "user@example.org" has role "Developer" in project named "Project One"
  And user "user@example.org" has role "Viewer" in project named "Project One"
  And user "member@example.org" has role "Viewer" in project named "Project One"

  When I go to the show project page for "Project One"
  And I follow "Members"
  Then I should not see "Edit membership" within ".members"

