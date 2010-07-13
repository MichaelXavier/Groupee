Feature: Authentication
  In order to prevent unauthorized use of the system
  a student or instructor
  wants to be able to log into Groupee

  Background:
    Given existing User:
        | first_name | last_name | email                   | password | password_confirmation |
        | Cranky     | Kong      | c.kong@crankyscabin.com | password | password              |
      And I am "c.kong@crankyscabin.com"
      And my account is confirmed
      And I log in with password "password"

  Scenario: User visits the site without logging in
     Given I am on the homepage
      Then I should see "You need to sign in or sign up before continuing"

  Scenario: User's account is locked
     Given I am on the homepage
       And my account is locked
      When I log in with password "password"
      Then I should see "Your account is locked"
      
  Scenario: User's account is not confirmed
     Given I am on the homepage
       And my account is not confirmed
      When I log in with password "password"
      Then I should see "You have to confirm your account before continuing"

  Scenario: User logs in correctly
     Given I am on the homepage
      When I log in with password "password"
      Then I should see "Signed in successfully"

  #TODO: confirmation, unlocks, etc
