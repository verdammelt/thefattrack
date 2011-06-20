Feature: Entering Today's Weight
  In order to keep track of my weight loss
  As a dieter
  I want to enter today's weight and get a report of my current progress

  Scenario: Enter weight and get updated current trend
    Given that the previous trend weight was 200
    And I enter 190 as today's weight
    When I click Save
    Then I see that the Current Trend is 199

  Scenario: Entering today's weight several times when there is no other data does not change trend
    Given that the previous trend weight was 200
    And I enter 190 as today's weight
    And I click Save
    And I enter 190 as today's weight
    When I click Save
    Then I see that the Current Trend is 199

#  Scenario: Entering the weight changes current weight
#    Given that today's weight is 200
#    And I enter 190 as today's weight
#    When I click Save
#    Then I see that today's weight is 190

