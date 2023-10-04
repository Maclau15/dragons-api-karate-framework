@Regression
Feature: Random Account Creation

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account with Random Email
    # call Java Class and Methos with Karate.
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/account/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      {
        "email": "#(autoEmail)",
        "firstName": "Lina",
        "lasttName": "Ruiz",
        "tile": "Ms.",
        "gender": "FEMALE",
        "maritalStatus": "SINGLE",
        "employmentStatus": "student",
        "dateOfBirth": "1990-10-09"
      }    
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
