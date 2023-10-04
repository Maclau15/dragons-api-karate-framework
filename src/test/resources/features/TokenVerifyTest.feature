#Scenario 5:
#endpoint = /api/token/verify
#With a vald token you should get response HTTP Status Code 200 and response true
@Smoke @Regression
Feature: Token Verify Test

  Background: Setup Test URL
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verify Valid Token
    And path "/api/token"
    And request { "username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "supervisor"
    When method get
    Then status 200
    And print response
    #And assert response.status == true
    #And assert response.httpStatus == "OK"
    #And assert response.message == "Token is valid"

  #Scenario 6:
  Scenario: Negative test validate token verify with wrong username
    And path "/api/token"
    And request { "username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "supervi1"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  #Scenario 7:
  Scenario: Negative test verify Token with invalidate token and valid username
    Given path "/api/token/verify"
    And param token = "invalid token"
    And param username = "supervisor"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
