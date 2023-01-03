Feature: Project Status

  As a REDCap end user
  I want to see that Project Status is functioning as expected

  Scenario: Project Setup - 1
    Given I am an "admin" user who logs into REDCap
    And I create a project named "11_ProjectStatus_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    When I click on the link labeled "User Rights"
    And I enter "test_user" into the field identified by "[id=new_username]"
    And I click on the button labeled "Add with custom rights"
    And I click on the checkbox identified by "[name=design]"
    And I click on the checkbox identified by "[name=user_rights]"
    And I click on the checkbox identified by "[name=data_access_groups]"
    And I click on the button labeled "Add user"

  Scenario: 1 -  Login as test user
    Given I am an "standard" user who logs into REDCap

  Scenario: 2 - Go to My Projects Page
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 

  Scenario: 3 - Move project to Production
    When I click on the button labeled "Move project to production"
    Then I should see "Request Admin to Move to Production Status?" 
    And I should see a button labeled "Yes, Request Admin to Move to Production Status"
    Then I click on the button labeled "Cancel"

  Scenario: 4 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 5 - Allow Normal Users to Move Project to Production
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    And I select "Yes, normal users can move projects to production" from the dropdown identified by "[name=superusers_only_move_to_prod]"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

  Scenario: 6  - Login as test user
    Given I logout
    And I am a "standard" user who logs into REDCap

  Scenario: 7 - Open 11_ProjectStatus_v1115
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 

  Scenario: 8 - Move Project to Production
    When I click on the button labeled "Move project to production"
    And I move the project to production by selection option "input#keep_data"
    When I click on the link labeled "Add / Edit Records"
    Then I should see the dropdown identified by "[id=record]" labeled "-- select record --" with the options below
    | 1 |

  Scenario: 9 - Other Functionality Tab 
    When I click on the link labeled "Project Setup"
    And I click on the link labeled "Other Functionality"
    Then I should NOT see "Move back to Development status"

  Scenario: 10 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 11 - Move Back to Development
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    And I click on the link labeled "Other Functionality"
    When I click on the button labeled "Move back to Development status"
      #does not ask for confirmation like in script
    Then I should see "The project is now back in development status."

  Scenario: 12 - Login as test user
    Given I logout
    And I am a "standard" user who logs into REDCap

  Scenario: 13 -  Move Project to Production
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115"
    When I click on the button labeled "Move project to production"
    And I move the project to production by selection option "input#delete_data"
    When I click on the link labeled "Add / Edit Records"
    Then I should see the dropdown identified by "[id=record]" labeled "-- select record --" with the options below
    | |
    When I click on the link labeled "Record Status Dashboard"
    Then I should see "No records exist yet"

  Scenario: 14 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 15 - Move Back to Development
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    And I click on the link labeled "Other Functionality"
    When I click on the button labeled "Move back to Development status"
      #does not ask for confirmation like in script
    Then I should see "The project is now back in development status."

  Scenario: 16 - Login as test user
    Given I logout
    And I am a "standard" user who logs into REDCap

  Scenario: 17 - Mark Project as Completed
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    And I click on the link labeled "Other Functionality"
    When I click on the button labeled "Mark project as Completed"
    And I click on the button labeled "Mark project as Completed" in the dialog box
  And I want to pause
      #there is a popup but not a "close" button. it closes on its own but takes too long which causes a timing issue
    Then I should NOT see "11_ProjectStatus_v1115"

  Scenario: 18 - Show Completed Projects
    When I click on the link labeled "Show Completed Projects"
    Then I should see a link labeled "11_ProjectStatus_v1115"
    When I click on the link labeled "11_ProjectStatus_v1115"
    Then I should see "NOTICE: Project was marked as Completed" 
    Then I should NOT see "Restore Project"

  Scenario: 19 - Return to My Projects Page
    Given I click on the button labeled "Return to My Projects page"

  Scenario: 20 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 21 - Restore Project
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Show Completed Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    Then I should see "NOTICE: Project was marked as Completed"
    When I click on the button labeled "Restore Project"
    Then I should see "PROJECT RESTORED!"
    And I close popup

  Scenario: 22 - Login as test user
    Given I logout
    And I am a "standard" user who logs into REDCap

  Scenario: 23 - Move Project to Production
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    When I click on the button labeled "Move project to production"
    And I move the project to production by selection option "input#keep_data"

  Scenario: 24 - Move Project to Analysis/Cleanup Status
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move to Analysis/Cleanup status"
    And I click on the button labeled "YES, Move to Analysis/Cleanup Status" in the dialog box
    Then I should see "This project is currently in Analysis/Cleanup status"

  Scenario: 25 - Lock Entire Record
    When I click on the button labeled "Modify"
    And I click on the button labeled "Set all project data as Read-only / Locked" in the dialog box
  And I want to pause
      #for whatever reason the status isnt updated without this pause
    Then I should see "Read-only / Locked"

  Scenario: 26 - Set to Editable
    When I click on the button labeled "Modify"
    And I click on the button labeled "Set to Editable (existing records only)" in the dialog box
  And I want to pause
      #for whatever reason the status isnt updated without this pause
    Then I should see "Editable (existing records only)"

  Scenario: 27 - Move Back to Production Status
    When I click on the button labeled "Move back to Production status"
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should NOT see "Move back to Development status"

  Scenario: 28 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 29 - Move Project to Analysis/Cleanup Status
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move to Analysis/Cleanup status"
    And I click on the button labeled "YES, Move to Analysis/Cleanup Status" in the dialog box
    Then I should see "This project is currently in Analysis/Cleanup status"

  Scenario: 30 - Move Project to Production
    When I click on the button labeled "Move back to Production status"
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
      #this is different that the script but difference is also noted in script  - 30 is marked as "fail"
  And I want to pause
      #this pause keeps scenario 31 from detaching 

  Scenario: 31 -  Mark Project as Completed
    When I click on the button labeled "Mark project as Completed"
    And I click on the button labeled "Mark project as Completed" in the dialog box
  And I want to pause
      #there is a popup but not a "close" button. it closes on its own but takes too long which causes a timing issue
    Then I should NOT see "11_ProjectStatus_v1115"

  Scenario: 32 - Show Completed Projects
    When I click on the link labeled "Show Completed Projects"
    Then I should see a link labeled "11_ProjectStatus_v1115"
    When I click on the link labeled "11_ProjectStatus_v1115"
    Then I should see "NOTICE: Project was marked as Completed" 
    When I click on the button labeled "Restore Project"
    Then I should see "PROJECT RESTORED!"
    And I close popup

  Scenario: 33 - Logout
    Given I logout



