Feature: Manage Groups
  In order to manage their membership to groups
  a student
  wants to be able to manage the groups to which he/she belongs

  Background:
    Given the following groups:
        | name                   | user_limit | website | open | id |
        | King K Rule Task Force | 0          |         | 1    | 1  |
        | Bonus Bonanza          | 2          |         | 1    | 2  |
        | No Entry               | 2          |         | 0    | 3  |
        | Funkys Flights         | 0          |         | 1    | 4  |
      And existing Users:
        | first_name | last_name | id | email          |
        | Diddy      | Kong      | 66  | diddy@dkc.com  |
        | Candy      | Kong      | 77  | candy@dkc.com  |
        | Swanky     | Kong      | 88  | swanky@dkc.com |
        | Donkey     | Kong      | 99  | donkey@dkc.com |
      And I am "diddy@dkc.com"
      And I have logged in as "diddy@dkc.com"

  Scenario: Listing current groups
    Given I am part of group 1
      And "Candy Kong" is part of group 1
      And I am on the groups page
     Then I should see "King K Rule Task Force" within "#current_groups"
      And I should see "Unlimited" within "#group_1"
      And I should see "Open" within "#group_1"

  Scenario: Listing suggested groups
    Given I am part of group 1
      And "Candy Kong" is part of group 1
      And I am on the groups page
     Then I should see "Bonus Bonanza" within "#suggested_groups"
      And I should see "No Entry" within "#suggested_groups"
      And I should see "2" within "#group_3"
      And I should see "Closed" within "#group_3"
      But I should not see "King K Rule Task Force" within "#suggested_groups"

  Scenario: Listing all groups
    Given I am on the groups page
     When I follow "Join another group"
     Then I should see the following groups:
        | Name                   | Member Limit | Website | Open    |
        | King K Rule Task Force | Unlimited    |         | Open    |
        | Bonus Bonanza          | 2            |         | Open    |
        | No Entry               | 2            |         | Closed  |
        | Funkys Flights         | Unlimited    |         | Open    |
