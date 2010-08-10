Feature: Manage Meetings
  In order to have productive meetings with other group members
  a student
  wants to be able to manage the meetings which they will be attending

  Background:
    Given existing User:
        | first_name | last_name | email                   | password | password_confirmation |
        | Cranky     | Kong      | c.kong@crankyscabin.com | password | password              |
      And existing Users:
        | first_name | last_name | id | email          |
        | Diddy      | Kong      | 66  | diddy@dkc.com  |
        | Candy      | Kong      | 77  | candy@dkc.com  |
        | Swanky     | Kong      | 88  | swanky@dkc.com |
        | Donkey     | Kong      | 99  | donkey@dkc.com |
      And I am "c.kong@crankyscabin.com"
      And the following groups:
        | name                   | user_limit | website | open | id |
        | King K Rule Task Force | 0          |         | 1    | 1  |
      And I am part of group 1

  @wip
  Scenario: Viewing scheduled meetings
    Given I have have the scheduled meeting:
      | title            | from_date                | to_date                  | id |
      | Project Planning | Next Wendesday at 3:00PM | Next Wednesday at 4:00PM | 1  |
    When I go to the meetings page
    Then I should see "Project Planning" within "#meetings"
    And  I should see "1 hour" within "#meeting_1"

  @wip
  Scenario: Scheduling a new meeting
    When I go to the meetings page
     And I follow "Schedule A Meeting"
     And I fill in "Next Thursday at 3:00PM" within "Start"
     And I fill in "Next Thursday at 5:00PM" within "Finish"
     And I fill in "Top Secret Mission" within "Title"
     And I press "Create Meeting"
    Then I should see "Top Secret Mission" within "#meetings"
     And I should see "2 hours" within "#meetings"

  @wip
  Scenario: Canceling a meeting
  #TODO

  @wip
  Scenario: Viewing a single meeting
  #TODO
