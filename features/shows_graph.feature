Feature: Viewing a graph of the weight and trend
  In order to get visual feedback of my weight loss
  As a dieter
  I want to see a graph showing my weight trend

  Scenario: Showing the graph
    Given I go to the weights page
    Then I see a Fat Track Graph
