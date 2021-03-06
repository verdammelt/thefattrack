Feature: Recent Weights Display
  In order to keep track of my weight loss
  As a dieter
  I want to see my recent weights, and trends with latest weight first

  Scenario: Recent weights displayed, trends rounded
    Given that the following data exists
      | date       | weight | trend     |
      | 2001-01-01 | 190    | 190       |
      | 2001-01-02 | 189    | 189.99    |
      | 2001-01-03 | 188    | 189.71    |
      | 2001-01-04 | 187    | 189.439   |
    When I go to the weights page
    Then the Recent Weights table will show
      | Date       | Weight   | Trend     |
      |            |          | 190.0       |
      | 2001-01-04 | 187.0    | 189.44    |
      | 2001-01-03 | 188.0    | 189.71    |
      | 2001-01-02 | 189.0    | 189.99    |
      | 2001-01-01 | 190.0    | 190.0     |

  Scenario: With no weights - nothing displayed
    Given that the following data exists
    | Date | Weight | Trend |
    When I go to the weights page
    Then the Recent Weights table will show
    | Date | Weight | Trend |
    |      |        | Trend |


    
