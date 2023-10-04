@Regression
Feature: Get Account API

  Background: API Setup steps
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get Account API Call with existing account
    And path "/api/token"
    And request { "username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    # def Step is to define new variable in Karate Framework
    * def generatedToken = response.token
    Given path "/api/accounts/get-account"
    And param primaryPersonId = "23882"
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == 23882
    And assert response.primaryPerson.email == "mcc@tekschool.us"
