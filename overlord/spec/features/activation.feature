Feature: activation
  In order to arm the bomb
  As a crazed lunatic
  I want to be able to enter a code into the activation input box

  Scenario: entering a non-numeric code
    Given I visit the root page
    And I fill in 'ABCD' for 'activation-code'
    When I press 'Activate'
    Then I should see 'Error:'

  Scenario: entering a numeric code
    Given I visit the root page
    And I fill in '1234' for 'activation-code'
    When I press 'Activate'
    Then I should see 'Success:'