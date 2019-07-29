
  Feature: Validate documentation page

    Background:
      Given navigate to site

    Scenario: Validate whether documentation page is loaded successfully
      And the page should load properly and return success status
      Then check angular is initialized when page loads

    Scenario: Validate the internal links for Global APIs and SDKs
      When navigate|verify and check for Angular initialization for internal links of "Global APIs and SDKs" and "China specific APIs and SDKs"
      Then verify success status of internal links and Angular initialization when page loads


