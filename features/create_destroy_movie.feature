Feature: Add and delete a movie

  As an admin
  So that I can create and remove movies
  I want to add and then remove a movie

  Background: movies have been added to database

    Given the following movies exist:
    | title                   | rating | release_date |
    | Aladdin                 | G      | 25-Nov-1992  |
    | The Terminator          | R      | 26-Oct-1984  |
    | When Harry Met Sally    | R      | 21-Jul-1989  |
    | The Help                | PG-13  | 10-Aug-2011  |
    | Chocolat                | PG-13  | 5-Jan-2001   |
    | Amelie                  | R      | 25-Apr-2001  |
    | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
    | The Incredibles         | PG     | 5-Nov-2004   |
    | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
    | Chicken Run             | G      | 21-Jun-2000  |

    
Scenario: Add the movie "The Avengers"
    Given I am on the home page
    And I follow "Add new movie"
    When I fill in "Title" with "The Avengers"
    And I press "Save Changes"
    Then  I should be on the home page
    And I should see "The Avengers was successfully created."

Scenario: Remove the movie "The Avengers"