@Regression
Feature: Create Account Test

  Background: API Setup steps
    #callone read is Karate Step to execute and read another feature file
    #the result of callone can store into new variable using "* def" step
    * def result = callone read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account
    Given path "/api/account/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "macla111@tekschool.us",
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
    And assert response.email == "macla111@tekschool.us"
    #Delete created account
    Given path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = response.id
    When method delete
    Then status 200
    And print response
    And assert response == "Account Succesfully deleted"
