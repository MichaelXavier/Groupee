Feature: Manage name:strings
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new name:string
    Given I am on the new name:string page
    When I fill in "User limit" with "user_limit 1"
    And I fill in "Status" with "status 1"
    And I fill in "Website" with "website 1"
    And I uncheck "Open"
    And I press "Create"
    Then I should see "user_limit 1"
    And I should see "status 1"
    And I should see "website 1"
    And I should see "false"

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity or Selenium2 (webdriver) when pages rely on
  # Javascript events. Only Culerity supports confirmation dialogs.
  #
  # Since Culerity and Selenium2 has some overhead, Cucumber-Rails will detect 
  # the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn off this emulation by tagging your scenario with @selenium, 
  # @culerity, @celerity or @javascript. (See the Capybara documentation for 
  # details about those tags). If any of these tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails'' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  # TODO: Verify with Rob what this means: The rack driver will detect the 
  # onclick javascript and emulate its behaviour without a real Javascript
  # interpreter.
  #
  Scenario: Delete name:string
    Given the following name:strings:
      |user_limit|status|website|open|
      |user_limit 1|status 1|website 1|false|
      |user_limit 2|status 2|website 2|true|
      |user_limit 3|status 3|website 3|false|
      |user_limit 4|status 4|website 4|true|
    When I delete the 3rd name:string
    Then I should see the following name:strings:
      |User limit|Status|Website|Open|
      |user_limit 1|status 1|website 1|false|
      |user_limit 2|status 2|website 2|true|
      |user_limit 4|status 4|website 4|true|
