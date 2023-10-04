@Smoke @Regression
Feature: API Test Security Section

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  @Test
  Scenario: Create token with valid username and password
    And request { "username": "supervisor", "password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 200
    And print response

  @Test
  Scenario: Validate token with invalid username
    And request { "username": "supervisor1", "password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  @Test
  Scenario: Validate token with invalid password
    And request { "username": "supervisor", "password": "tek123"}
    #Send request
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.errorMessage == "Password Not Matched"
    And assert response.httpStatus=="BAD_REQUEST"
