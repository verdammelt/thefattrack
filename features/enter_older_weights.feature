Feature: Entering Prior Day's Weights
  In order to keep track of my weight loss
  As a dieter
  I want to enter prior day's weights

  Scenario: Enter yesterday's weight and see updated trends
    Given that the following data exists
      | date       | weight | trend  |
      | 2001-01-01 | 190    | 190    |
      | 2001-01-02 | 189    | 189.99 | 
    And I go to the weights page
    And I enter 2001-01-01 as the date
    And I enter 189 as the weight
    When I click Save
    Then I see that the Current Trend is 189
    And the Recent Weights table will show
      | Date       | Weight | Trend | 
      | 2001-01-02 | 189.0  | 189.0 |
      | 2001-01-01 | 189.0  | 189.0 |

  Scenario: The date field defaults to today's date
    Given that today is 2001-01-01
    When I go to the weights page
    Then I see that the date field is 2001-01-01

