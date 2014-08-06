Feature: deactivation
  In order to disarm the bomb
  As a crazed lunatic
  I want to be able to enter a code into the deactivation input box

  Scenario: entering a non-numeric code
    Given the bomb is activated
    And I fill in 'ABCD' for 'deactivation-code'
    When I press 'Deactivate'
    Then I should see 'Error:'

  Scenario: entering a numeric code
    Given the bomb is activated
    And I fill in '1234' for 'deactivation-code'
    When I press 'Deactivate'
    Then I should see 'Success:'

  Scenario: entering a non-numeric code 3 times
    Given the bomb is activated
    And I fill in 'A' for 'deactivation-code'
    And I press 'Deactivate'
    And I fill in 'A' for 'deactivation-code'
    And I press 'Deactivate'
    And I fill in 'A' for 'deactivation-code'
    And I press 'Deactivate'
    Then I should see 'EXPLODE'