Feature: Instructor Mode
  In order to make sure that students get the most out of the site
  an instructor
  wants to be able to manage courses and assignments

  Background:
    Given I have logged in as instructor "c.kong@crankyscabin.com"
      And I teach the following courses:
        | title            | sln   | catalog_name | id |
        | Social Computing | 12345 | CSS490       | 1  |
      And existing Users enrolled in course with sln 12345:
        | first_name | last_name | id | email          |
        | Candy      | Kong      | 77  | candy@dkc.com  |
        | Swanky     | Kong      | 88  | swanky@dkc.com |
      And existing Assignments in course with sln 12345:
        | id | name        | user_limit  | assigned                       | due                |
        | 77  | Practicum 1 | 2          | date(2 weeks ago on wednesday) | date(last monday)  |
        | 88  | Practicum 2 | 5          | date(last wednesday)           | date(next tuesday) |

  Scenario: Explicit instructor mode
     Given I am on the homepage
      Then I should see "Instructor Mode"  

  Scenario: Confirming courses being taught
     Given I am on the courses page
      Then I should see "You are currently teaching 1 course"
       And I should see "CSS490" within "#current_courses"
       And I should see "Manage Course" within "#course_1"

  Scenario: Listing enrolled users
     Given I am on the manage course 1 page 
      Then I should see "Candy Kong" within "#enrolled_users"
       And I should see "Swanky Kong" within "#enrolled_users"
       And I should see an email link with "candy@dkc.com" within "#user_77"

  Scenario: Removing a users from the course
     Given I am on the manage course 1 page 
      When I press "Remove User" within "#user_77"
      Then I should see "Swanky Kong" within "#user_88"
       And I should see "Student Candy Kong was successfully removed from the course"
       But I should not see "Candy Kong" within "#enrolled_users"
       #TODO: verify emails?

  Scenario: Listing assignments
     Given I am on the manage course 1 page 
      Then I should see "Practicum 1" within "#assignments"
       And I should see "Practicum 2" within "#assignments"
       And I should see "Expired" within "#assignment_77"
       And I should see "In Progress" within "#assignment_88"
       #TODO: group setup and assertions

  Scenario: Creating assignment
     Given I am on the manage course 1 page 
      When I follow "Add Assignment"
       And I fill in "Name" with "Practicum 3" 
       And I fill in "Member Limit" with "5" 
       And I select "7/14/2010" from date field "assignment_assigned"
       And I select "7/16/2010" from date field "assignment_due"
       And I press "Create"
      When I am on the manage course 1 page 
      Then I should see "Practicum 3" within "#assignments"
