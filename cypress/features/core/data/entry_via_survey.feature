Feature: Data Entry through the Survey

  As a REDCap end user
  I want to see that Data Entry through the Survey is functioning as expected

  Scenario: An external user visits a public survey
    Given I visit the public survey URL for Project ID 3
    Then I should see "Example Survey" in the title

  Scenario: A standard user enters data into a public survey
    Given I visit the public survey URL for Project ID 9
    And I enter "user1@yahoo.com" into the "E-mail address" survey text input field

    When I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey"

  Scenario: A standard user disables survey functionality
    Given I visit Project ID 9
    And I disable surveys for Project ID 9

    When I visit the "Data Entry" page with parameter string of "pid=9&id=1&page=prescreening_survey"
    Then I should see that the "E-mail address" field contains the value of "user1@yahoo.com"

  Scenario: A standard user distributes a survey to a list of users
    Given I visit Project ID 9
    And I enable surveys for Project ID 9

    When I visit the "Surveys/invite_participants.php" page with parameter string of "pid=9"
    And I click on the link labeled "Participant List"
    Then I should see "Email"

  Scenario: A standard user generates a survey from within a participant record using Log Out + Open Survey
    Given I visit Project ID 9
    And I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I click on the table cell containing a link labeled "Pre-Screening Survey"
    And I click on the button labeled "Save & Exit Form"
    And I click on the table cell containing a link labeled "Pre-Screening Survey"
    And I click on the button labeled "Survey options"

    When I click on the survey option label containing "Log out" label and want to track the response with a tag of "logout_open_survey"
    Then I should see the survey open exactly once by watching the tag of "logout_open_survey"

  Scenario: A standard user is prompted to leave the survey to avoid overwriting survey responses when opening surveys from data entry form
    Given I visit Project ID 9
    And I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I click on the table cell containing a link labeled "Pre-Screening Survey"
    And I click on the button labeled "Save & Exit Form"
    And I click on the table cell containing a link labeled "Pre-Screening Survey"
    And I click on the button labeled "Survey options"

    When I click on the survey option label containing "Open survey" label
    Then I should see "Leave without saving changes"
    And I should see "Stay on page"

  Scenario: A standard user is prompted to leave the survey to avoid overwriting survey responses when opening surveys from data entry form
    Given I visit Project ID 9
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Online Designer"
    Then I should see "Draft Mode"

    When I click on the input button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    When I click on the link labeled "Record Status Dashboard"
    When I click on the bubble for the "Pre-Screening Survey" data collection instrument
