@mod @mod_assign @javascript
Feature: Manage assignment submission web notifications
  In order to receive assignment submission notifications
  As a teacher
  I need to be able to turn on web notifications for assignment submission

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | student1 | Student   | 1        | student1@example.com |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student        |
    And the following "activity" exists:
      | activity                            | assign   |
      | course                              | C1       |
      | name                                | Assign 1 |
      | assignsubmission_onlinetext_enabled | 1        |
      | assignsubmission_file_enabled       | 0        |
      | submissiondrafts                    | 0        |
      | sendnotifications                   | 1        |
    And the following "mod_assign > submissions" exist:
      | assign   | user     | onlinetext                  |
      | Assign 1 | student1 | I'm the student1 submission |

  Scenario: Teacher can choose to receive assignment notification submissions
    Given I log in as "teacher1"
    When I open the notification popover
    Then I should see "You have no notifications"
    # Enable assignment submission notification
    And I follow "Preferences" in the user menu
    And I click on "Notification preferences" "link" in the "#page-content" "css_element"
    And I click on "//td[@data-processor-name='popup']//label[@class='preference-state']" "xpath_element" in the "Assignment notifications" "table_row"
    # Update assignment submission to generate a notification
    And I am on the "Assign 1" "assign activity" page logged in as student1
    # This should generate a notification
    And I press "Edit submission"
    And I set the field "Online text" to "updated"
    And I press "Save changes"
    # Confirm that teacher received assignment submission notification
    And I log in as "teacher1"
    And I open the notification popover
    Then I should see "Student 1 has updated their submission for assignment Assign 1"
