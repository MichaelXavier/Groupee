Feature: Manage Courses
  In order to manage groups based around school courses
  a student
  wants to be able to manage the courses to which he/she belongs

  Background:
    Given I have logged in as "c.kong@crankyscabin.com"
      And existing Course for user:
        | title            | sln   | catalog_name |
        | Social Computing | 12345 | CSS490       |
      And existing Courses:
        | title                    | sln   | catalog_name |
        | Bonus Bonanza            | 67890 | BIS100       |
        | Advanced Barrel Throwing | 52891 | BIS220       |
      And I am on the courses page

  Scenario: List of current courses
      Then I should see "You are currently enrolled in 1 course"
       And I should see "CSS490" within "#current_courses"

  @wip
  Scenario: Find a course by SLN
      Then I should see "Find a course"
      When I fill in "SLN Number" with "67890"
       And I press "Find Course"
      Then I should see "Bonus Bonanza"
       And I should not see "Advanced Barrel Throwing"

  @wip
  Scenario: Find a course by title with partial
      When I fill in "Title" with "Barrel"
       And I press "Find Course"
      Then I should see "Advanced Barrel Throwing"
       And I should not see "Bonus Bonanza"

  @wip
  Scenario: Enroll in a course
     Given I fill in "SLN Number" with "67890"
       And I press "Find Course"
      When I follow "Enroll in Course"
      Then I should see "BIS100" within "current_courses"

  @wip
  Scenario: Drop a course
      Given I should see "Drop Course" within "current_courses"
       When I follow "Drop Course"
       Then I should see "You are not currently enrolled in any courses"

  @wip
  Scenario: View course info
      Given Course with sln:"12345" has users:
        | first_name | last_name | email                           |
        | Funky      | Kong      | f.kong@funkysflights.com        |
        | Diddy      | Kong      | d.kong@dkr.com                  |
        | Donkey     | Kong      | don.key.kong@supersmashbros.com |
       When I follow "CSS490"
       Then I should see "Funky Kong"
        And I should see "Diddy Kong"
        And I should see "Donkey Kong"
        #TODO: more feature assertions
