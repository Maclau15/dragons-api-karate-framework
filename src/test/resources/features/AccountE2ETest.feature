#End 2 End Account Testing
#Create account
#Add Address, Add phone, Add car, Get Account
#Note: Everything in 1 scenario
@Regression
Feature: End-to-End Account Testing

  Background: API Setup steps
    * def result = callone read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: End-to-End Account Creation Testing
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def emailAddressData = dataGenerator.getEmail()
    Given path "/api/account/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
        "email": "#(emailAddressData)",
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
    And assert response.email == emailAddressData
    And assert response.firstName == "Lina"
    * def generatedAccountId = response.id
    Given path "/api/accounts/add-account-address"
    And param primaryPersondId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {      
      "addressType": "Home",
      "addressLine1": "8072 Leanne Terr",
      "city": "Reston",
      "state": "VA",
      "postalCode": "20148",
      "countryCode": "",
      "current": true
      }        
      """
    When method post
    Then status 201
    And print response
    And assert response.addressLine1 == "8072 Leanne Terr"
    Given path "/api/accounts/add-account-phone"
    And param primaryPersondId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    * def randomPhoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(randomPhoneNumber)",
      "phoneExtension": "",
      "phoneTime": "Any time",
      "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == randomPhoneNumber
    Given path "/api/accounts/add-account-car"
    And param primaryPersondId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    * def randomLicensePlate = dataGenerator.getLicensePlate()
    And request
      """
      {
      "make": "Tesla",
      "model": "a",
      "year": "2023",
      "licensePlate": "#(randomLicensePlate)"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.licensePlate == randomLicensePlate
    Given path "/api/accounts/get-account"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == generatedAccountId
