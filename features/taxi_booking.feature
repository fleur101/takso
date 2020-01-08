Feature: Taxi booking
  As a customer
  Such that I go to destination
  I want to arrange a taxi ride

  Scenario: Login via STRS' web page (with confirmation)
    Given I want to login with username "fred" and password "parool"
    And I open login page
    And I enter login information
    When I submit the login request
    Then I should receive a greeting message

  Scenario: Booking via STRS' web page (with confirmation)
    Given the following taxis are on duty
          | username | location	     | status    | capacity |  cost   |
          | samSmith | Juhan Liivi 2 | busy      | 2        |  10.0   |
          | jamesMcavoy  | Kalevi 4      | available | 4    |   9.0   |
    And I want to go from "Juhan Liivi 2" to "Muuseumi tee 2"
    And I open STRS' web page
    And I enter the booking information
    When I submit the booking request
    Then I see a list of available taxis with full names "Sam Smith" and "James McAvoy"
    And I select "samSmith" and "jamesMcavoy"
    When I submit the taxi request
    Then I see a list of selected taxis
    Given "jamesMcavoy" first accepts booking
    And I refresh page
    Then I see my booking accepted by "James McAvoy"

  # Scenario: Booking via STRS' web page (with rejection)
  #   Given the following taxis are on duty
  #         | username  | location  | status |
  #         | juhan85   | Kaubamaja | busy   |
  #         | peeter88  | Kaubamaja | busy   |
  #   And I want to go from "Liivi 2" to "Lõunakeskus"
  #   And I open STRS' web page
  #   And I enter the booking information
  #   When I summit the booking request
  #   Then I should receive a rejection message