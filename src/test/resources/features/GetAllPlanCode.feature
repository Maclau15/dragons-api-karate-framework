Feature: Get All Plan Code

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Get All Plan Code
    And path "/api/plans/get-all-plan-code"
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
